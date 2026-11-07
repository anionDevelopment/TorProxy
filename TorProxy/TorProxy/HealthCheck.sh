#!/bin/bash

# Checks whether tor is running and whether it works.
# The check uses the control-socket which is reserved for the healthcheck (see torrc.template).
# Tor is considered healthy when both of the following conditions are met:
# - The bootstrap is finished, which means tor is connected to the tor-network.
# - Tor has established a circuit, which means it is able to build connections through the tor-network, which is required to provide the hidden service.

healthchecksocket="/run/tor/healthcheck.sock"

response=$(printf 'AUTHENTICATE\r\nGETINFO status/bootstrap-phase status/circuit-established\r\nQUIT\r\n' | socat -t 5 - "UNIX-CONNECT:${healthchecksocket}")
if [[ $? -ne 0 ]]; then
  echo "The control-socket \"${healthchecksocket}\" of tor is not reachable."
  exit 1
fi

if ! grep -q "status/bootstrap-phase=.*PROGRESS=100" <<< "${response}"; then
  echo "The bootstrap of tor is not finished. Response of tor: ${response}"
  exit 1
fi

if ! grep -q "status/circuit-established=1" <<< "${response}"; then
  echo "Tor has not established a circuit. Response of tor: ${response}"
  exit 1
fi

echo "Tor is bootstrapped and has established a circuit."
exit 0

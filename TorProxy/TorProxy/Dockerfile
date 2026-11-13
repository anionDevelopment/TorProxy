ARG image_debian
FROM ${image_debian}
ARG CodeUnitVersion
ARG DotNetRuntime
ARG tor_version
ARG socat_version
LABEL version=${CodeUnitVersion}
ENV ISRUNNINGINCONTAINER="true"
#TODO make it possible to have an own apt-server for apt-packages to get rid of rate limits


ARG TorKey=A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
ARG TorURL=https://deb.torproject.org/torproject.org
LABEL maintainer "marius.goecke@gmail.com"
LABEL description="TorProxy is a docker-image for running a hidden service in a docker-container."
LABEL targetEnvironmentType="$TargetEnvironmentType"
LABEL version="$Version"

RUN apt-get -y update && \
    apt-get -y install wget gpg lsb-release && \
    mkdir /Workspace && \
    mkdir /Workspace/Application && \
    mkdir /Workspace/Data && \
    echo "   deb     [signed-by=/usr/share/keyrings/deb.torproject.org-keyring.gpg] $TorURL $(lsb_release -cs) main" | tee -a /etc/apt/sources.list.d/tor.list && \
    wget -qO- https://deb.torproject.org/torproject.org/$TorKey.asc | gpg --dearmor | tee /usr/share/keyrings/deb.torproject.org-keyring.gpg >/dev/null && \
    apt-get update && apt-get install -y tor=${tor_version} deb.torproject.org-keyring socat=${socat_version} && \
    echo "Tor version: $(tor --version)" && \
    apt-get -y purge wget gpg lsb-release apt-transport-https && \
    apt-get -y clean

WORKDIR /Workspace/Data

COPY ./TorProxy/torrc.template /Workspace/Application/torrc
COPY ./TorProxy/EntryPoint.sh /Workspace/Application/EntryPoint.sh
COPY ./TorProxy/HealthCheck.sh /Workspace/Application/HealthCheck.sh

# The executable-bit is set explicitly because the build-context does not necessarily provide it (for example when the build runs on a filesystem which does not support unix-permissions).
RUN chmod 0755 /Workspace/Application/HealthCheck.sh

HEALTHCHECK --interval=60s --timeout=10s --start-period=300s --retries=3 CMD ["/Workspace/Application/HealthCheck.sh"]

ENTRYPOINT ["/Workspace/Application/EntryPoint.sh"]

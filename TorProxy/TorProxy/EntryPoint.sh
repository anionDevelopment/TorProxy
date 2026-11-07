#!/bin/bash

configurationfile="/Workspace/Application/torrc"

# Tor requires that the hidden-service-directory is only accessible by the user which runs tor.
# Directories need the executable-bit to be traversable, so directories get 700 and files get 600.
find "/var/lib/tor/$hiddenservicedir" -type d -exec chmod 700 {} +
find "/var/lib/tor/$hiddenservicedir" -type f -exec chmod 600 {} +

sed -i -e "s/__.torrc.hiddenservicedir.__/$hiddenservicedir/g" $configurationfile
sed -i -e "s/__.torrc.hiddenserviceport.__/$hiddenserviceport/g" $configurationfile
sed -i -e "s/__.torrc.hiddenserviceaddress.__/$hiddenserviceaddress/g" $configurationfile

if [[ "${lognotice}" = true ]]; then
  sed -i -e "s/__.torrc.lognotice.__/Log notice file \/var\/log\/tor\/notices.log/g" $configurationfile
else
  sed -i -e "s/__.torrc.lognotice.__//g" $configurationfile
fi
if [[ "${logdebug}" = true ]]; then
  sed -i -e "s/__.torrc.logdebug.__/Log debug file \/var\/log\/tor\/debug.log/g" $configurationfile
else
  sed -i -e "s/__.torrc.logdebug.__//g" $configurationfile
fi

# Tor only creates a unix-socket in a directory which is owned by the user which runs tor and which is not accessible by other users.
# The directory is created on every start because /run can be a tmpfs which is empty after a restart.
mkdir -p /run/tor
chmod 0700 /run/tor

echo "--------------------"
echo "Tor-version:"
tor --version
echo "--------------------"
echo "Tor-Configuration:"
cat $configurationfile
echo "--------------------"
echo "Starting tor..."
tor -f $configurationfile
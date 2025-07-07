#!/bin/bash

configurationfile="/Workspace/Application/torrc"

chmod 700 "/var/lib/tor/$hiddenservicedir"
chmod -r 600 "/var/lib/tor/$hiddenservicedir/"

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

echo "--------------------"
echo "Tor-version:"
tor --version
echo "--------------------"
echo "Tor-Configuration:"
cat $configurationfile
echo "--------------------"
echo "Starting tor..."
tor -f $configurationfile
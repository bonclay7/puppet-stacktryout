#!/bin/bash

PRGNAME=$(basename $0)

# ** WARNING : Configure Properly this section **
PUPPETMASTER='192.168.1.39'
BRIDGEIFACE='eth1'

#Setting Language
export LC_ALL=`echo $LANG`

# Check if we are root
if [ "Z$USER" != "Zroot" ] ; then
  echo "You need to execute this script as root:"
  echo "sudo sh $PRGNAME"
  exit 1
fi

# Installing Puppet
echo "*** Installing and configuring puppet ***"
wget -q -P /tmp https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i /tmp/puppetlabs-release-trusty.deb
apt-get update >/dev/null
apt-get -y install puppet >/dev/null


# configuring management network
if [ $BRIDGEIFACE ]; then
  echo "*** Configuring management network ***"
  echo "auto $BRIDGEIFACE" >> /etc/network/interfaces
  echo "iface $BRIDGEIFACE inet manual" >> /etc/network/interfaces
  echo '    up ifconfig $IFACE 0.0.0.0 up' >> /etc/network/interfaces
  echo '    up ifconfig $IFACE promisc' >> /etc/network/interfaces
fi


echo "*** Installing OpenStack ***"
echo "$PUPPETMASTER stackpuppetmaster.home" >> /etc/hosts
echo '[agent]' >> /etc/puppet/puppet.conf
echo 'server = stackpuppetmaster.home' >> /etc/puppet/puppet.conf
puppet agent --verbose --no-daemonize --onetime

echo "*** Are we good ? ***"

# Cleaning /tmp files
rm -Rf /tmp/puppetlabs-release-trusty.deb

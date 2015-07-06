#!/bin/bash

PRGNAME=$(basename $0)

# ** WARNING : Configure Properly this section **
PUPPETMASTER='192.168.1.39'
MGMTIFACE='eth1'


# Check if we are root
if [ "Z$USER" != "Zroot" ] ; then
  echo "You need to execute this script as root:"
  echo "sudo $PRGNAME"
  exit 1
fi

# Installing Puppet
echo "*** Installing and configuring puppet ***"
wget -q -P /tmp https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i /tmp/puppetlabs-release-trusty.deb
apt-get update
apt-get -y install puppet


# configuring management network
echo "*** Configuring management network ***"
echo "auto $MGMTIFACE" >> /etc/network/interfaces
echo "iface $MGMTIFACE inet manual" >> /etc/network/interfaces
echo '    up ifconfig $IFACE 0.0.0.0 up' >> /etc/network/interfaces
echo '    up ifconfig $IFACE promisc' >> /etc/network/interfaces


echo "*** Installing OpenStack ***"
echo "$PUPPETMASTER stackpuppetmaster" >> /etc/hosts
echo '[agent]' >> /etc/puppet/puppet.conf
echo 'server = stackpuppetmaster' >> /etc/puppet/puppet.conf
puppet agent --verbose --no-daemonize --onetime

echo "*** Are we good ? ***"

# Cleaning /tmp files
rm -Rf /tmp/puppetlabs-release-trusty.deb

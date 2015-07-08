#OpenStack with Puppet

This project gathers many projects from OpenStack and StackForge Puppet efforts and
brings a simple tool to have a clean OpenStack Juno installation on a <b>Single Node</b>
all in one OpenStack installation perfects for testing purposes.

<pre><code>
$ git clone https://github.com/bonclay7/puppet-stacktryout.git
</code></pre>



## Puppet Master
We use vagrant with VirtualBox to build up quickly a server running a puppet master
but you can also, install the puppet master on the same node as your OpenStack server.

<pre><code>
$ cd puppet-stacktryout/puppetmaster
$ vagrant up
$ vagrant ssh
$ sudo sed -i "s/192.168.1.37/OPENSTACK IP/g" /etc/puppet/hieradata/production/common.yaml
$ sudo service apache2 restart
</code></pre>

## Configuring the client (future OpenStack server)

We consider, at this point you have a Trusty Ubuntu Server (14.04) fresh install and running. Your Puppetmaster running as well.
We can launch our allinone OpenStack server using the prepare-openstack-server.sh
script. (do it as root)

But You will need to update those two variables :
<pre><code>
# ** WARNING : Configure Properly this section **
PUPPETMASTER='192.168.1.39'
BRIDGEIFACE='eth1'
</code></pre>

And then :

<pre><code>
$ git clone https://github.com/bonclay7/puppet-stacktryout.git
$ cd puppet-stacktryout/
$ sed -i "s/192.168.1.39/YOUR PUPPETMASTER IP/" prepare-openstack-server.sh
$ sed -i "s/eth1/YOUR IFACE or LEAVE IT BLANK/" prepare-openstack-server.sh
$ sudo sh prepare-openstack-server.sh
</code></pre>


## TO-DO
- Fix Heat Domain Users (keystone user-role-add --user admin --tenant admin --role heat_stack_owner)

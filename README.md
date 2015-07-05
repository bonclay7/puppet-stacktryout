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
</code></pre>

## Configuring the client (future OpenStack server)

We consider, at this point you have a Trusty Ubuntu Server (14.04) fresh install and running.
First of all, we install puppet agent :

<pre><code>
$ wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
$ sudo dpkg -i puppetlabs-release-trusty.deb
$ sudo apt-get update
$ sudo apt-get install puppet
$ echo '192.168.1.98 stackpuppetmaster' >> /etc/hosts
$ sudo puppet agent --verbose --no-daemonize --onetime
</code></pre>

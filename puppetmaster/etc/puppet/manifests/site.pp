# Set exec path for all modules
Exec { path => '/usr/bin:/usr/sbin:/bin:/sbin' }

import 'allinone.pp'


class linux {

  $admintools = ['git', 'nano', 'screen']

  package { $admintools:
    ensure => 'installed',
  }

  $ntpservice = $osfamily ? {
    'redhat'  => 'ntpd',
    'debian'  => 'ntp',
    'default' => 'ntp',
  }

  file { '/info.txt':
    ensure  => present,
    content => inline_template("Created by Puppet at <%= Time.now %>\n"),
  }

  package { 'ntp':
    ensure => installed,
  }

  service { $ntpservice:
    ensure => 'running',
    enable => true,
  }
}

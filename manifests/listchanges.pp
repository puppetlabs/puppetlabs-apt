# Class: apt::listchanges
#
# This class manages the apt-listchanges package and related configuration
# files for debian
#
class apt::listchanges (
  $frontend       = 'pager',
  $email_address  = 'root',
  $confirm        = 0,
  $save_seen      = '/var/lib/apt/listchanges.db',
  $which          = 'news',
) inherits ::apt::params {

  package { 'apt-listchanges':
    ensure => present,
  }

  file { '/etc/apt/listchanges.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['apt-listchanges'],
  }

  ini_setting { 'frontend':
    path    => '/etc/apt/listchanges.conf',
    ensure  => present,
    section => 'apt',
    setting => 'frontend',
    value   => $frontend,
  }

  ini_setting { 'email_address':
    path    => '/etc/apt/listchanges.conf',
    ensure  => present,
    section => 'apt',
    setting => 'email_address',
    value   => $email_address,
  }

  ini_setting { 'confirm':
    path    => '/etc/apt/listchanges.conf',
    ensure  => present,
    section => 'apt',
    setting => 'confirm',
    value   => $confirm,
  }

  ini_setting { 'save_seen':
    path    => '/etc/apt/listchanges.conf',
    ensure  => present,
    section => 'apt',
    setting => 'save_seen',
    value   => $save_seen,
  }

  ini_setting { 'which':
    path    => '/etc/apt/listchanges.conf',
    ensure  => present,
    section => 'apt',
    setting => 'which',
    value   => $which,
  }
}

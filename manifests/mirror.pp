# Install and configure apt-mirror
#
# == parameters
#
# [*mirror_url*]
#   source repo url
#
# [ base_path, mirror_path, skel_path, var_path: ]
#    Set different directory locations
#
# [ cleanscript ]
#    Script to do clean
#
# [ postmirror_script ]
#    path to postmirror script
#
# [ run_postmirror ]
#    Whether to run postmirror script or not
#
# [ nthreads ]
#    Number of threads.
#
# == Examples
#
#  class {'::apt::mirror':
#    nthreads => 10,
#  }
#
# == Authors
#
# Harish Kumar <hkumarmk@gmail.com>
#
# == Copyright
#
# Copyright 2011 Puppet Labs Inc, unless otherwise noted.

class apt::mirror(
    $base_path         = '/var/spool/apt-mirror',
    $mirror_path       = '$base_path/mirror',
    $skel_path         = '$base_path/skel',
    $var_path          = '$base_path/var',
    $cleanscript       = '$base_path/clean.sh',
    $postmirror_script = '$var_path/postmirror.sh',
    $defaultarch       = 'amd64',
    $run_postmirror    = '0',
    $nthreads          = '20',
    $_tilde            = '0',
    $package_ensure    = present,
  ) {

  ## Install apt-mirror package
  package { 'apt-mirror':
    ensure => $package_ensure,
  }

  ## Add base configuration in mirror.list

  concat { '/etc/apt/mirror.list':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['apt-mirror'],
  }

  concat::fragment { "apt-mirror-${name}.conf":
    target  => '/etc/apt/mirror.list',
    order   => '1',
    content => template('apt/mirror.list-base.erb'),
  }
}


# @summary Provides defaults for the Apt module parameters.
#
# @api private
#
class apt::params {
  if $facts['os']['family'] != 'Debian' {
    fail('This module only works on Debian or derivatives like Ubuntu')
  }

  $root                 = '/etc/apt'
  $provider             = '/usr/bin/apt-get'
  $sources_list         = "${root}/sources.list"
  $sources_list_force   = false
  $sources_list_d       = "${root}/sources.list.d"
  $trusted_gpg_d        = "${root}/trusted.gpg.d"
  $conf_d               = "${root}/apt.conf.d"
  $preferences          = "${root}/preferences"
  $preferences_d        = "${root}/preferences.d"
  $apt_conf_d           = "${root}/apt.conf.d"
  $keyserver            = 'keyserver.ubuntu.com'
  $key_options          = undef
  $confs                = {}
  $update               = {}
  $purge                = {}
  $proxy                = {}
  $sources              = {}
  $keys                 = {}
  $ppas                 = {}
  $pins                 = {}
  $settings             = {}
  $manage_auth_conf     = true
  $auth_conf_entries    = []

  $config_files = {
    'conf'   => {
      'path' => $conf_d,
      'ext'  => '',
    },
    'pref'   => {
      'path' => $preferences_d,
      'ext'  => '.pref',
    },
    'list'   => {
      'path' => $sources_list_d,
      'ext'  => '.list',
    },
  }

  $update_defaults = {
    'frequency' => 'reluctantly',
    'loglevel'  => undef,
    'timeout'   => undef,
    'tries'     => undef,
  }

  $proxy_defaults = {
    'ensure'     => undef,
    'host'       => undef,
    'port'       => 8080,
    'https'      => false,
    'https_acng' => false,
    'direct'     => false,
  }

  $purge_defaults = {
    'sources.list'   => false,
    'sources.list.d' => false,
    'preferences'    => false,
    'preferences.d'  => false,
    'apt.conf.d'     => false,
  }

  $include_defaults = {
    'deb' => true,
    'src' => false,
  }

  case $facts['os']['name'] {
    'Debian': {
      $backports = {
        'location' => 'http://deb.debian.org/debian',
        'repos'    => 'main contrib non-free',
      }
      $ppa_options = undef
      $ppa_package = undef
      $auth_conf_owner = '_apt'
    }
    'Ubuntu': {
      $backports = {
        'location' => 'http://archive.ubuntu.com/ubuntu',
        'key'      => '630239CC130E1A7FD81A27B140976EAF437D05B5',
        'repos'    => 'main universe multiverse restricted',
      }
      $ppa_options        = ['-y']
      $ppa_package        = 'software-properties-common'
      $auth_conf_owner = '_apt'
    }
    undef: {
      fail('Unable to determine value for fact os[\"name\"]')
    }
    default: {
      $ppa_options = undef
      $ppa_package = undef
      $backports   = undef
      $auth_conf_owner = 'root'
    }
  }
}

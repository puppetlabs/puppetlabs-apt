class apt::params {

  if $::osfamily != 'Debian' {
    fail('This module only works on Debian or derivatives like Ubuntu')
  }

  # Strict variables facts lookup compatibility
  $xfacts = {
    'lsbdistcodename' => defined('$lsbdistcodename') ? {
      true    => $::lsbdistcodename,
      default => undef,
    },
    'lsbdistrelease' => defined('$lsbdistrelease') ? {
      true    => $::lsbdistrelease,
      default => undef,
    },
    'lsbmajdistrelease' => defined('$lsbmajdistrelease') ? {
      true    => $::lsbmajdistrelease,
      default => undef,
    },
    'lsbdistdescription' => defined('$lsbdistdescription') ? {
      true    => $::lsbdistdescription,
      default => undef,
    },
    'lsbminordistrelease' => defined('$lsbminordistrelease') ? {
      true    => $::lsbminordistrelease,
      default => undef,
    },
    'lsbdistid' => defined('$lsbdistid') ? {
      true    => $::lsbdistid,
      default => undef,
    },
  }

  $root           = '/etc/apt'
  $provider       = '/usr/bin/apt-get'
  $sources_list   = "${root}/sources.list"
  $sources_list_d = "${root}/sources.list.d"
  $conf_d         = "${root}/apt.conf.d"
  $preferences    = "${root}/preferences"
  $preferences_d  = "${root}/preferences.d"
  $keyserver      = 'keyserver.ubuntu.com'

  $config_files = {
    'conf'   => {
      'path' => $conf_d,
      'ext'  => '',
    },
    'pref'   => {
      'path' => $preferences_d,
      'ext'  => '',
    },
    'list'   => {
      'path' => $sources_list_d,
      'ext'  => '.list',
    }
  }

  $update_defaults = {
    'frequency' => 'reluctantly',
    'timeout'   => undef,
    'tries'     => undef,
  }

  $proxy_defaults = {
    'host'  => undef,
    'port'  => 8080,
    'https' => false,
  }

  $purge_defaults = {
    'sources.list'   => true,
    'sources.list.d' => true,
    'preferences'    => true,
    'preferences.d'  => true,
  }

  $source_key_defaults = {
    'server'  => $keyserver,
    'options' => undef,
    'content' => undef,
    'source'  => undef,
  }

  $include_defaults = {
    'deb' => true,
    'src' => false,
  }

  case $xfacts['lsbdistid'] {
    'ubuntu', 'debian': {
      $distid = $xfacts['lsbdistid']
      $distcodename = $xfacts['lsbdistcodename']
    }
    'linuxmint': {
      if $xfacts['lsbdistcodename'] == 'debian' {
        $distid = 'debian'
        $distcodename = 'wheezy'
      } else {
        $distid = 'ubuntu'
        $distcodename = $xfacts['lsbdistcodename'] ? {
          'qiana'  => 'trusty',
          'petra'  => 'saucy',
          'olivia' => 'raring',
          'nadia'  => 'quantal',
          'maya'   => 'precise',
        }
      }
    }
    'Cumulus Networks': {
      $distid = 'debian'
      $distcodename = $::lsbdistcodename
    }
    undef: {
      fail('Unable to determine lsbdistid, is lsb-release installed?')
    }
    default: {
      fail("Unsupported lsbdistid (${::lsbdistid})")
    }
  }
  case $distid {
    'debian': {
      case $distcodename {
        'squeeze': {
          $backports = {'location' => 'http://backports.debian.org/debian-backports',
                        'key'       => 'A1BD8E9D78F7FE5C3E65D8AF8B48AD6246925553',
                        'repos'     => 'main contrib non-free',
          }
        }
        default: {
          $backports = {'location' => 'http://ftp.debian.org/debian/',
                        'key'       => 'A1BD8E9D78F7FE5C3E65D8AF8B48AD6246925553',
                        'repos'     => 'main contrib non-free',
          }
        }
      }
    }
    'ubuntu': {
      $backports = {'location' => 'http://archive.ubuntu.com/ubuntu',
                    'key'       => '630239CC130E1A7FD81A27B140976EAF437D05B5',
                    'repos'     => 'main universe multiverse restricted',
      }
      case $distcodename {
        'lucid': {
          $ppa_options        = undef
          $ppa_package        = 'python-software-properties'
        }
        'precise': {
          $ppa_options        = '-y'
          $ppa_package        = 'python-software-properties'
        }
        'trusty', 'utopic', 'vivid': {
          $ppa_options        = '-y'
          $ppa_package        = 'software-properties-common'
        }
        default: {
          $ppa_options        = '-y'
          $ppa_package        = 'python-software-properties'
        }
      }
    }
    '', default: {
      $ppa_options = undef
      $ppa_package = undef
      $backports   = undef
    }
  }
}

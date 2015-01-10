# ppa.pp

define apt::ppa(
  $ensure  = 'present',
  $release = $::lsbdistcodename,
  $options = $apt::params::ppa_options,
) {
  include apt::params
  include apt::update

  $sources_list_d = $apt::params::sources_list_d

  if ! $release {
    fail('lsbdistcodename fact not available: release parameter required')
  }

  if $::operatingsystem != 'Ubuntu' and $::operatingsystem != 'LinuxMint' {
    fail('apt::ppa is currently supported on Ubuntu and LinuxMint only.')
  }

  $addaptrepository = '/usr/bin/add-apt-repository'
  if $::operatingsystem == 'LinuxMint' {
    # Prior to LinuxMint 17.1 (rebecca) the mintsources package installed a
    # LinuxMint-specific add-apt-repository under /usr/local/bin.  As of 17.1 the
    # software-properties-common package is no longer installed and mintsources
    # puts add-apt-repository under /usr/bin
    if versioncmp($::lsbdistrelease, '17') <= 0 {
      $addaptrepository = '/usr/local/bin/add-apt-repository'
    }
  }

  $filename_without_slashes = regsubst($name, '/', '-', 'G')
  $filename_without_dots    = regsubst($filename_without_slashes, '\.', '_', 'G')
  $filename_without_ppa     = regsubst($filename_without_dots, '^ppa:', '', 'G')
  $sources_list_d_filename  = "${filename_without_ppa}-${release}.list"

  if $ensure == 'present' {
    if $::operatingsystem == 'LinuxMint' {
      $package = 'mintsources'
    }
    else {
      $package = $::lsbdistrelease ? {
          /^[1-9]\..*|1[01]\..*|12.04$/ => 'python-software-properties',
          default  => 'software-properties-common',
      }
    }

    if ! defined(Package[$package]) {
        package { $package: }
    }

    if defined(Class[apt]) {
        $proxy_host = $apt::proxy_host
        $proxy_port = $apt::proxy_port
        case $proxy_host {
          false, '', undef: {
            $proxy_env = []
          }
          default: {
            $proxy_env = ["http_proxy=http://${proxy_host}:${proxy_port}", "https_proxy=http://${proxy_host}:${proxy_port}"]
          }
        }
    } else {
        $proxy_env = []
    }
    exec { "add-apt-repository-${name}":
        environment => $proxy_env,
        command     => "${addaptrepository} ${options} ${name}",
        unless      => "/usr/bin/test -s ${sources_list_d}/${sources_list_d_filename}",
        user        => 'root',
        logoutput   => 'on_failure',
        notify      => Exec['apt_update'],
        require     => [
        File['sources.list.d'],
        Package[$package],
        ],
    }

    file { "${sources_list_d}/${sources_list_d_filename}":
        ensure  => file,
        require => Exec["add-apt-repository-${name}"],
    }
  }
  else {

    file { "${sources_list_d}/${sources_list_d_filename}":
        ensure => 'absent',
        notify => Exec['apt_update'],
    }
  }

  # Need anchor to provide containment for dependencies.
  anchor { "apt::ppa::${name}":
    require => Class['apt::update'],
  }
}

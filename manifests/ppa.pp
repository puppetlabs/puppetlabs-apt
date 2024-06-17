# @summary Manages PPA repositories using `add-apt-repository`. Not supported on Debian.
#
# @example Example declaration of an Apt PPA
#   apt::ppa{ 'ppa:openstack-ppa/bleeding-edge': }
#
# @param ensure
#   Specifies whether the PPA should exist. Valid options: 'present' and 'absent'.
#
# @param options
#   Supplies options to be passed to the `add-apt-repository` command. Default: '-y'.
#
# @param release
#   Specifies the operating system of your node. Valid options: a string containing a valid LSB distribution codename.
#   Optional if `puppet facts show os.distro.codename` returns your correct distribution release codename.
#
# @param dist
#   Specifies the distribution of your node. Valid options: a string containing a valid distribution codename.
#   Optional if `puppet facts show os.name` returns your correct distribution name.
#
# @param package_name
#   Names the package that provides the `apt-add-repository` command. Default: 'software-properties-common'.
#
# @param package_manage
#   Specifies whether Puppet should manage the package that provides `apt-add-repository`.
#
define apt::ppa (
  String $ensure                        = 'present',
  Optional[Array[String]] $options      = $apt::ppa_options,
  Optional[String] $release             = fact('os.distro.codename'),
  Optional[String] $dist                = $facts['os']['name'],
  Optional[String] $package_name        = $apt::ppa_package,
  Boolean $package_manage               = false,
) {
  unless $release {
    fail('os.distro.codename fact not available: release parameter required')
  }

  if $dist == 'Debian' {
    fail('apt::ppa is not currently supported on Debian.')
  }

  # Validate the resource name
  if $name !~ /^ppa:([a-zA-Z0-9\-_.]+)\/([a-zA-z0-9\-_\.]+)$/ {
    fail("Invalid PPA name: ${name}")
  }

  $distid = downcase($dist)
  $dash_filename = regsubst($name, '^ppa:([^/]+)/(.+)$', "\\1-${distid}-\\2")
  $underscore_filename = regsubst($name, '^ppa:([^/]+)/(.+)$', "\\1_${distid}_\\2")

  $dash_filename_no_slashes      = regsubst($dash_filename, '/', '-', 'G')
  $dash_filename_no_specialchars = regsubst($dash_filename_no_slashes, '[\.\+]', '_', 'G')
  $underscore_filename_no_slashes      = regsubst($underscore_filename, '/', '-', 'G')
  $underscore_filename_no_specialchars = regsubst($underscore_filename_no_slashes, '[\.\+]', '_', 'G')

  $sources_list_d_filename = if versioncmp($facts['os']['release']['full'], '23.10') < 0 {
    "${dash_filename_no_specialchars}-${release}.list"
  } else {
    $"${dash_filename_no_specialchars}-${release}.sources"
  }

  if versioncmp($facts['os']['release']['full'], '21.04') < 0 {
    $trusted_gpg_d_filename = "${underscore_filename_no_specialchars}.gpg"
  } else {
    $trusted_gpg_d_filename = "${dash_filename_no_specialchars}.gpg"
  }

  # This is the location of our main exec script.
  $cache_path = $facts['puppet_vardir']
  $script_path = "${cache_path}/add-apt-repository-${dash_filename_no_specialchars}-${release}.sh"

  if $ensure == 'present' {
    if $package_manage {
      stdlib::ensure_packages($package_name)
      $_require = [File['sources.list.d'], Package[$package_name]]
    } else {
      $_require = File['sources.list.d']
    }

    $_proxy = $apt::_proxy
    if $_proxy['host'] {
      if $_proxy['https'] {
        $_proxy_env = ["http_proxy=http://${$_proxy['host']}:${$_proxy['port']}", "https_proxy=https://${$_proxy['host']}:${$_proxy['port']}"]
      } else {
        $_proxy_env = ["http_proxy=http://${$_proxy['host']}:${$_proxy['port']}"]
      }
    } else {
      $_proxy_env = []
    }

    unless $sources_list_d_filename in $facts['apt_sources'] {
      $script_content = epp('apt/add-apt-repository.sh.epp', {
          command                 => ['/usr/bin/add-apt-repository', shell_join($options), $name],
          sources_list_d_path     => $apt::sources_list_d,
          sources_list_d_filename => $sources_list_d_filename,
        }
      )

      file { "add-apt-repository-script-${name}":
        ensure  => 'file',
        path    => $script_path,
        content => $script_content,
        mode    => '0755',
      }

      exec { "add-apt-repository-${name}":
        environment => $_proxy_env,
        command     => $script_path,
        logoutput   => 'on_failure',
        notify      => Class['apt::update'],
        require     => $_require,
        before      => File["${apt::sources_list_d}/${sources_list_d_filename}"],
      }
    }

    file { "${apt::sources_list_d}/${sources_list_d_filename}": }
  }
  else {
    tidy { "remove-apt-repository-script-${name}":
      path => $script_path,
    }

    tidy { "remove-apt-repository-${name}":
      path   => "${apt::sources_list_d}/${sources_list_d_filename}",
      notify => Class['apt::update'],
    }
  }
}

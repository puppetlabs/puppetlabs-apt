# @summary Main class, includes all other classes.
#
# @see https://docs.puppetlabs.com/references/latest/function.html#createresources for the create resource function
#
# @param provider
#   Specifies the provider that should be used by apt::update.
#
# @param keyserver
#   Specifies a keyserver to provide the GPG key. Valid options: a string containing a domain name or a full URL (http://, https://, or
#   hkp://).
#
# @param key_options
#   Specifies the default options for apt::key resources.
#
# @param ppa_options
#   Supplies options to be passed to the `add-apt-repository` command.
#
# @param ppa_package
#   Names the package that provides the `apt-add-repository` command.
#
# @param backports
#   Specifies some of the default parameters used by apt::backports. Valid options: a hash made up from the following keys:
#
# @option backports [String] :location
#   See apt::backports for documentation.
#
# @option backports [String] :repos
#   See apt::backports for documentation.
#
# @option backports [String] :key
#   See apt::backports for documentation.
#
# @param confs
#   Hash of `apt::conf` resources.
#
# @param update
#   Configures various update settings. Valid options: a hash made up from the following keys:
#
# @option update [String] :frequency
#   Specifies how often to run `apt-get update`. If the exec resource `apt_update` is notified,
#   `apt-get update` runs regardless of this value.
#   Valid options:
#     'always' (at every Puppet run);
#     'hourly' (if the value of `apt_update_last_success` is less than current epoch time minus 3600);
#     'daily'  (if the value of `apt_update_last_success` is less than current epoch time minus 86400);
#     'weekly' (if the value of `apt_update_last_success` is less than current epoch time minus 604800);
#     Integer  (if the value of `apt_update_last_success` is less than current epoch time minus provided Integer value);
#     'reluctantly' (only if the exec resource `apt_update` is notified).
#   Default: 'reluctantly'.
#
# @option update [Integer] :loglevel
#   Specifies the log level of logs outputted to the console. Default: undef.
#
# @option update [Integer] :timeout
#   Specifies how long to wait for the update to complete before canceling it. Valid options: an integer, in seconds. Default: undef.
#
# @option update [Integer] :tries
#    Specifies how many times to retry the update after receiving a DNS or HTTP error. Default: undef.
#
# @param update_defaults
#   The default update settings that are combined and merged with the passed `update` value
#
# @param purge
#   Specifies whether to purge any existing settings that aren't managed by Puppet. Valid options: a hash made up from the following keys:
#
# @option purge [Boolean] :sources.list
#   Specifies whether to purge any unmanaged entries from sources.list. Default false.
#
# @option purge [Boolean] :sources.list.d
#   Specifies whether to purge any unmanaged entries from sources.list.d. Default false.
#
# @option purge [Boolean] :preferences
#   Specifies whether to purge any unmanaged entries from preferences. Default false.
#
# @option purge [Boolean] :preferences.d.
#   Specifies whether to purge any unmanaged entries from preferences.d. Default false.
#
# @param purge_defaults
#   The default purge settings that are combined and merged with the passed `purge` value
#
# @param proxy
#   Configures Apt to connect to a proxy server. Valid options: a hash matching the locally defined type apt::proxy.
#
# @param proxy_defaults
#   The default proxy settings that are combined and merged with the passed `proxy` value
#
# @param sources
#   Hash of `apt::source` resources.
#
# @param keys
#   Hash of `apt::key` resources.
#
# @param keyrings
#   Hash of `apt::keyring` resources.
#
# @param ppas
#   Hash of `apt::ppa` resources.
#
# @param pins
#   Hash of `apt::pin` resources.
#
# @param settings
#   Hash of `apt::setting` resources.
#
# @param manage_auth_conf
#   Specifies whether to manage the /etc/apt/auth.conf file. When true, the file will be overwritten with the entries specified in
#   the auth_conf_entries parameter. When false, the file will be ignored (note that this does not set the file to absent.
#
# @param auth_conf_entries
#   An optional array of login configuration settings (hashes) that are recorded in the file /etc/apt/auth.conf. This file has a netrc-like
#   format (similar to what curl uses) and contains the login configuration for APT sources and proxies that require authentication. See
#   https://manpages.debian.org/testing/apt/apt_auth.conf.5.en.html for details. If specified each hash must contain the keys machine, login and
#   password and no others. Specifying manage_auth_conf and not specifying this parameter will set /etc/apt/auth.conf to absent.
#
# @param auth_conf_owner
#   The owner of the file /etc/apt/auth.conf.
#
# @param root
#   Specifies root directory of Apt executable.
#
# @param sources_list
#   Specifies the path of the sources_list file to use.
#
# @param sources_list_d
#   Specifies the path of the sources_list.d file to use.
#
# @param conf_d
#   Specifies the path of the conf.d file to use.
#
# @param preferences
#   Specifies the path of the preferences file to use.
#
# @param preferences_d
#   Specifies the path of the preferences.d file to use.
#
# @param config_files
#   A hash made up of the various configuration files used by Apt.
#
# @param sources_list_force
#   Specifies whether to perform force purge or delete.
#
# @param include_defaults
#   The package types to include by default.
#
# @param apt_conf_d
#   The path to the file `apt.conf.d`
#
# @param source_key_defaults
#   The fault `source_key` settings
#
class apt (
  Hash $update_defaults = {
    'frequency' => 'reluctantly',
    'loglevel'  => undef,
    'timeout'   => undef,
    'tries'     => undef,
  },
  Hash $purge_defaults = {
    'sources.list'   => false,
    'sources.list.d' => false,
    'preferences'    => false,
    'preferences.d'  => false,
    'apt.conf.d'     => false,
  },
  Hash $proxy_defaults = {
    'ensure'     => undef,
    'host'       => undef,
    'port'       => 8080,
    'https'      => false,
    'https_acng' => false,
    'direct'     => false,
  },
  Hash $include_defaults = {
    'deb' => true,
    'src' => false,
  },
  Stdlib::Absolutepath $provider = '/usr/bin/apt-get',
  Stdlib::Host $keyserver = 'keyserver.ubuntu.com',
  Optional[String[1]] $key_options = undef,
  Optional[Array[String[1]]] $ppa_options = undef,
  Optional[String[1]] $ppa_package = undef,
  Optional[Hash] $backports = undef,
  Hash $confs = {},
  Hash $update = {},
  Hash $purge = {},
  Apt::Proxy $proxy = {},
  Hash $sources = {},
  Hash $keys = {},
  Hash $keyrings = {},
  Hash $ppas = {},
  Hash $pins = {},
  Hash $settings = {},
  Boolean $manage_auth_conf = true,
  Array[Apt::Auth_conf_entry] $auth_conf_entries = [],
  String[1] $auth_conf_owner = '_apt',
  Stdlib::Absolutepath $root = '/etc/apt',
  Stdlib::Absolutepath $sources_list = "${root}/sources.list",
  Stdlib::Absolutepath $sources_list_d = "${root}/sources.list.d",
  Stdlib::Absolutepath $conf_d = "${root}/apt.conf.d",
  Stdlib::Absolutepath $preferences = "${root}/preferences",
  Stdlib::Absolutepath $preferences_d = "${root}/preferences.d",
  Stdlib::Absolutepath $apt_conf_d = "${root}/apt.conf.d",
  Hash $config_files = {
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
  },
  Boolean $sources_list_force = false,
  Hash $source_key_defaults = {
    'server'  => $keyserver,
    'options' => undef,
    'content' => undef,
    'source'  => undef,
  },
) {
  if $facts['os']['family'] != 'Debian' {
    fail('This module only works on Debian or derivatives like Ubuntu')
  }

  if $update['frequency'] {
    assert_type(
      Variant[Enum['always','hourly','daily','weekly','reluctantly'],Integer[60]],
      $update['frequency'],
    )
  }
  if $update['timeout'] {
    assert_type(Integer, $update['timeout'])
  }
  if $update['tries'] {
    assert_type(Integer, $update['tries'])
  }

  $_update = $apt::update_defaults + $update
  include apt::update

  if $purge['sources.list'] {
    assert_type(Boolean, $purge['sources.list'])
  }
  if $purge['sources.list.d'] {
    assert_type(Boolean, $purge['sources.list.d'])
  }
  if $purge['preferences'] {
    assert_type(Boolean, $purge['preferences'])
  }
  if $purge['preferences.d'] {
    assert_type(Boolean, $purge['preferences.d'])
  }
  if $sources_list_force {
    assert_type(Boolean, $sources_list_force)
  }
  if $purge['apt.conf.d'] {
    assert_type(Boolean, $purge['apt.conf.d'])
  }

  $_purge = $apt::purge_defaults + $purge

  if $proxy['perhost'] {
    $_perhost = $proxy['perhost'].map |$item| {
      $_item = $apt::proxy_defaults + $item
      $_scheme = $_item['https'] ? {
        true    => 'https',
        default => 'http',
      }
      $_port = $_item['port'] ? {
        Integer => ":${_item['port']}",
        default => ''
      }
      $_target = $_item['direct'] ? {
        true    => 'DIRECT',
        default => "${_scheme}://${_item['host']}${_port}/",
      }
      $item + { 'scheme' => $_scheme, 'target' => $_target, }
    }
  } else {
    $_perhost = {}
  }

  $_proxy = $apt::proxy_defaults + $proxy + { 'perhost' => $_perhost }

  $confheadertmp = epp('apt/_conf_header.epp')
  $proxytmp = epp('apt/proxy.epp', { 'proxies' => $_proxy })
  $updatestamptmp = file('apt/15update-stamp')

  if $_proxy['ensure'] == 'absent' or $_proxy['host'] {
    apt::setting { 'conf-proxy':
      ensure   => $_proxy['ensure'],
      priority => '01',
      content  => "${confheadertmp}${proxytmp}",
    }
  }

  if $sources_list_force {
    $sources_list_ensure = $_purge['sources.list'] ? {
      true    => absent,
      default  => file,
    }
    $sources_list_content = $_purge['sources.list'] ? {
      true    => nil,
      default => undef,
    }
  } else {
    $sources_list_ensure = $_purge['sources.list'] ? {
      true    => file,
      default => file,
    }
    $sources_list_content = $_purge['sources.list'] ? {
      true    => "# Repos managed by puppet.\n",
      default => undef,
    }
  }

  $preferences_ensure = $_purge['preferences'] ? {
    true    => absent,
    default => file,
  }

  apt::setting { 'conf-update-stamp':
    priority => 15,
    content  => "${confheadertmp}${updatestamptmp}",
  }

  file { 'sources.list':
    ensure  => $sources_list_ensure,
    path    => $apt::sources_list,
    owner   => root,
    group   => root,
    content => $sources_list_content,
    notify  => Class['apt::update'],
  }

  file { 'sources.list.d':
    ensure  => directory,
    path    => $apt::sources_list_d,
    owner   => root,
    group   => root,
    purge   => $_purge['sources.list.d'],
    recurse => $_purge['sources.list.d'],
    notify  => Class['apt::update'],
  }

  file { 'preferences':
    ensure => $preferences_ensure,
    path   => $apt::preferences,
    owner  => root,
    group  => root,
    notify => Class['apt::update'],
  }

  file { 'preferences.d':
    ensure  => directory,
    path    => $apt::preferences_d,
    owner   => root,
    group   => root,
    purge   => $_purge['preferences.d'],
    recurse => $_purge['preferences.d'],
    notify  => Class['apt::update'],
  }

  file { 'apt.conf.d':
    ensure  => directory,
    path    => $apt::apt_conf_d,
    owner   => root,
    group   => root,
    purge   => $_purge['apt.conf.d'],
    recurse => $_purge['apt.conf.d'],
    notify  => Class['apt::update'],
  }

  $confs.each |$key, $value| {
    apt::conf { $key:
      * => $value,
    }
  }

  $sources.each |$key, $value| {
    apt::source { $key:
      * => $value,
    }
  }

  $keys.each |$key, $value| {
    apt::key { $key:
      * => $value,
    }
  }

  $keyrings.each |$key, $data| {
    apt::keyring { $key:
      * => $data,
    }
  }

  $ppas.each |$key, $value| {
    apt::ppa { $key:
      * => $value,
    }
  }

  $settings.each |$key, $value| {
    apt::setting { $key:
      * => $value,
    }
  }

  if $manage_auth_conf {
    $auth_conf_ensure = $auth_conf_entries ? {
      []      => 'absent',
      default => 'present',
    }

    $auth_conf_tmp = stdlib::deferrable_epp('apt/auth_conf.epp',
      {
        'auth_conf_entries' => $auth_conf_entries,
      },
    )

    file { '/etc/apt/auth.conf':
      ensure  => $auth_conf_ensure,
      owner   => $auth_conf_owner,
      group   => 'root',
      mode    => '0600',
      content => Sensitive($auth_conf_tmp),
      notify  => Class['apt::update'],
    }
  }

  $pins.each |$key, $value| {
    apt::pin { $key:
      * => $value,
    }
  }

  case $facts['os']['name'] {
    'Debian': {
      stdlib::ensure_packages(['gnupg'])
    }
    'Ubuntu': {
      stdlib::ensure_packages(['gnupg'])
    }
    default: {
      # Nothing in here
    }
  }
}

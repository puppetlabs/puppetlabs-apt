# == Class: apt
#
# Manage APT (Advanced Packaging Tool)
#
class apt (
  Variant[Hash, Stdlib::Compat::Hash] $update_defaults,
  Variant[Hash, Stdlib::Compat::Hash] $purge_defaults,
  Variant[Hash, Stdlib::Compat::Hash] $proxy_defaults,
  Variant[Hash, Stdlib::Compat::Hash] $include_defaults,
  Variant[String, Stdlib::Compat::String] $provider,
  Variant[String, Stdlib::Compat::String] $keyserver,
  Variant[String, Stdlib::Compat::String] $ppa_options,
  Variant[String, Stdlib::Compat::String] $ppa_package,
  Optional[Variant[Hash, Stdlib::Compat::Hash]] $backports,
  Variant[Hash, Stdlib::Compat::Hash] $confs                = {},
  Variant[Hash, Stdlib::Compat::Hash] $update               = {},
  Variant[Hash, Stdlib::Compat::Hash] $purge                = {},
  Variant[Hash, Stdlib::Compat::Hash] $proxy                = {},
  Variant[Hash, Stdlib::Compat::Hash] $sources              = {},
  Variant[Hash, Stdlib::Compat::Hash] $keys                 = {},
  Variant[Hash, Stdlib::Compat::Hash] $ppas                 = {},
  Variant[Hash, Stdlib::Compat::Hash] $pins                 = {},
  Variant[Hash, Stdlib::Compat::Hash] $settings             = {},
  Variant[String, Stdlib::Compat::String] $root             = '/etc/apt',
  Variant[String, Stdlib::Compat::String] $sources_list     = "${root}/sources.list",
  Variant[String, Stdlib::Compat::String] $sources_list_d   = "${root}/sources.list.d",
  Variant[String, Stdlib::Compat::String] $conf_d           = "${root}/apt.conf.d",
  Variant[String, Stdlib::Compat::String] $preferences      = "${root}/preferences",
  Variant[String, Stdlib::Compat::String] $preferences_d    = "${root}/preferences.d",
  Variant[Hash, Stdlib::Compat::Hash] $config_files         = { conf => { path => $conf_d, ext => '' }, pref => { path => $preferences_d, ext => '.pref' }, list => { path => $sources_list_d, ext => '.list' } },
  Variant[Hash, Stdlib::Compat::Hash] $source_key_defaults  = { 'server' => $keyserver, 'options' => undef, 'content' => undef, 'source' => undef },
) {

  if $facts['osfamily'] != 'Debian' {
    fail('This module only works on Debian or derivatives like Ubuntu')
  }

  $frequency_options = ['always','daily','weekly','reluctantly']
  validate_legacy(Hash, 'validate_hash', $update)
  if $update['frequency'] {
    validate_re($update['frequency'], $frequency_options)
  }
  if $update['timeout'] {
    unless is_integer($update['timeout']) {
      fail('timeout value for update must be an integer')
    }
  }
  if $update['tries'] {
    unless is_integer($update['tries']) {
      fail('tries value for update must be an integer')
    }
  }

  $_update = merge($::apt::update_defaults, $update)

  include ::apt::update

  validate_hash($purge)
  if $purge['sources.list'] {
    validate_legacy(Boolean, 'validate_bool', $purge['sources.list'])
  }
  if $purge['sources.list.d'] {
    validate_legacy(Boolean, 'validate_bool', $purge['sources.list.d'])
  }
  if $purge['preferences'] {
    validate_legacy(Boolean, 'validate_bool', $purge['preferences'])
  }
  if $purge['preferences.d'] {
    validate_legacy(Boolean, 'validate_bool', $purge['preferences.d'])
  }

  $_purge = merge($::apt::purge_defaults, $purge)

  validate_hash($proxy)
  if $proxy['ensure'] {
    validate_re($proxy['ensure'], ['file', 'present', 'absent'])
  }
  if $proxy['host'] {
    validate_legacy(String, 'validate_string', $proxy['host'])
  }
  if $proxy['port'] {
    unless is_integer($proxy['port']) {
      fail('$proxy port must be an integer')
    }
  }
  if $proxy['https'] {
    validate_legacy(Boolean, 'validate_bool', $proxy['https'])
  }

  $_proxy = merge($apt::proxy_defaults, $proxy)

  validate_legacy(Hash, 'validate_hash', $confs)
  validate_legacy(Hash, 'validate_hash', $sources)
  validate_legacy(Hash, 'validate_hash', $keys)
  validate_legacy(Hash, 'validate_hash', $settings)
  validate_legacy(Hash, 'validate_hash', $ppas)
  validate_legacy(Hash, 'validate_hash', $pins)

  $confheadertmp = epp('apt/_conf_header.epp')
  $proxytmp = epp('apt/proxy.epp', {'proxies' => $_proxy})
  $updatestamptmp = epp('apt/15update-stamp.epp')

  if $_proxy['ensure'] == 'absent' or $_proxy['host'] {
    apt::setting { 'conf-proxy':
      ensure   => $_proxy['ensure'],
      priority => '01',
      content  => "${confheadertmp}${proxytmp}",
    }
  }

  $sources_list_content = $_purge['sources.list'] ? {
    true    => "# Repos managed by puppet.\n",
    default => undef,
  }

  $preferences_ensure = $_purge['preferences'] ? {
    true    => absent,
    default => file,
  }

  if $_update['frequency'] == 'always' {
    Exec <| title=='apt_update' |> {
      refreshonly => false,
    }
  }

  apt::setting { 'conf-update-stamp':
    priority => 15,
    content  => "${confheadertmp}${updatestamptmp}",
  }

  file { 'sources.list':
    ensure  => file,
    path    => $::apt::sources_list,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => $sources_list_content,
    notify  => Class['apt::update'],
  }

  file { 'sources.list.d':
    ensure  => directory,
    path    => $::apt::sources_list_d,
    owner   => root,
    group   => root,
    mode    => '0644',
    purge   => $_purge['sources.list.d'],
    recurse => $_purge['sources.list.d'],
    notify  => Class['apt::update'],
  }

  file { 'preferences':
    ensure => $preferences_ensure,
    path   => $::apt::preferences,
    owner  => root,
    group  => root,
    mode   => '0644',
    notify => Class['apt::update'],
  }

  file { 'preferences.d':
    ensure  => directory,
    path    => $::apt::preferences_d,
    owner   => root,
    group   => root,
    mode    => '0644',
    purge   => $_purge['preferences.d'],
    recurse => $_purge['preferences.d'],
    notify  => Class['apt::update'],
  }

  if $confs {
    create_resources('apt::conf', $confs)
  }
  # manage sources if present
  if $sources {
    create_resources('apt::source', $sources)
  }
  # manage keys if present
  if $keys {
    create_resources('apt::key', $keys)
  }
  # manage ppas if present
  if $ppas {
    create_resources('apt::ppa', $ppas)
  }
  # manage settings if present
  if $settings {
    create_resources('apt::setting', $settings)
  }

  # manage pins if present
  if $pins {
    create_resources('apt::pin', $pins)
  }
}

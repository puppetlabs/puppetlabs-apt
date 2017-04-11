# == Class: apt
#
# Manage APT (Advanced Packaging Tool)
#
class apt (
  Hash $update_defaults,
  Hash $purge_defaults,
  Hash $proxy_defaults,
  Hash $include_defaults,
  String $provider,
  String $keyserver,
  Optional[String] $ppa_options,
  Optional[String] $ppa_package,
  Optional[Hash] $backports,
  Hash $confs                = {},
  Hash $update               = {},
  Hash $purge                = {},
  Hash $proxy                = {},
  Hash $sources              = {},
  Hash $keys                 = {},
  Hash $ppas                 = {},
  Hash $pins                 = {},
  Hash $settings             = {},
  String $root               = '/etc/apt',
  String $sources_list       = "${root}/sources.list",
  String $sources_list_d     = "${root}/sources.list.d",
  String $conf_d             = "${root}/apt.conf.d",
  String $preferences        = "${root}/preferences",
  String $preferences_d      = "${root}/preferences.d",
  Hash $config_files         = { conf => { path => $conf_d, ext => '' }, pref => { path => $preferences_d, ext => '.pref' }, list => { path => $sources_list_d, ext => '.list' } },
  Hash $source_key_defaults  = { 'server' => $keyserver, 'options' => undef, 'content' => undef, 'source' => undef },
) {

  if $facts['osfamily'] != 'Debian' {
    fail('This module only works on Debian or derivatives like Ubuntu')
  }

  $frequency_options = ['always','daily','weekly','reluctantly']

  if $update['frequency'] {
    validate_re($update['frequency'], $frequency_options)
  }
  if $update['timeout'] {
    assert_type(Integer, $update['timeout'])
  }
  if $update['tries'] {
    assert_type(Integer, $update['tries'])
  }

  $_update = merge($::apt::update_defaults, $update)

  include ::apt::update

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

  $_purge = merge($::apt::purge_defaults, $purge)

  if $proxy['ensure'] {
    validate_re($proxy['ensure'], ['file', 'present', 'absent'])
  }
  if $proxy['host'] {
    assert_type(String, $proxy['host'])
  }
  if $proxy['port'] {
    assert_type(Integer, $proxy['port'])
  }
  if $proxy['https']{
    assert_type(Boolean, $proxy['https'])
  }

  $_proxy = merge($apt::proxy_defaults, $proxy)

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

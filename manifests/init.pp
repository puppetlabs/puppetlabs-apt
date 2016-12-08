# == Class: apt
#
# Manage APT (Advanced Packaging Tool)
#
class apt (
  $confs    = {},
  $update   = {},
  $purge    = {},
  $proxy    = {},
  $sources  = {},
  $keys     = {},
  $ppas     = {},
  $pins     = {},
  $settings = {},
) inherits ::apt::params {

  $frequency_options = ['always','daily','weekly','reluctantly']
  validate_hash($update)
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
    validate_bool($purge['sources.list'])
  }
  if $purge['sources.list.d'] {
    validate_bool($purge['sources.list.d'])
  }
  if $purge['preferences'] {
    validate_bool($purge['preferences'])
  }
  if $purge['preferences.d'] {
    validate_bool($purge['preferences.d'])
  }

  $_purge = merge($::apt::purge_defaults, $purge)

  validate_hash($proxy)
  if $proxy['ensure'] {
    validate_re($proxy['ensure'], ['file', 'present', 'absent'])
  }
  if $proxy['port'] {
    validate_integer($proxy['port'], 65535, 0)
  }
  if $proxy['https'] {
    validate_bool($proxy['https'])
  }
  # Validate that $proxy['host'] is a valid, usable domain name or IP address
  if $proxy['host'] and size($proxy['host']) > 3 {
    # '.' is an RFC-valid domain name, but not usable in this context
    if is_ipv4_address($proxy['host']) or is_domain_name($proxy['host']) {
      $proxy['safehost'] = $proxy['host']
    } elsif is_ipv6_address($proxy['host']) {
      # IPv6 needs to be enclosed in [] to be used properly in the template
      $proxy['safehost'] = enclose_ipv6($proxy['host'])
    } else {
      # Invalid proxy host format
      fail("The proxy['host'] specified ( ${proxy['host']} ) is not a valid IP or hostname.")
    }
    fail("The proxy['host'] specified ( ${proxy['host']} ) is too small to be a valid IP or hostname.")
  }

  $_proxy = merge($apt::proxy_defaults, $proxy)

  if $_proxy['ensure'] == 'absent' or $_proxy['host'] {
    apt::setting { 'conf-proxy':
      ensure   => $_proxy['ensure'],
      priority => '01',
      content  => template('apt/_conf_header.erb', 'apt/proxy.erb'),
    }
  }

  validate_hash($confs)
  validate_hash($sources)
  validate_hash($keys)
  validate_hash($settings)
  validate_hash($ppas)
  validate_hash($pins)

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
    content  => template('apt/_conf_header.erb', 'apt/15update-stamp.erb'),
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

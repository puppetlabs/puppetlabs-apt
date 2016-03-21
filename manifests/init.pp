#
class apt(
  $update               = {},
  $purge                = {},
  $proxy                = {},
  $sources              = {},
  $sources_hiera_merge  = false,
  $keys                 = {},
  $keys_hiera_merge     = false,
  $ppas                 = {},
  $ppas_hiera_merge     = false,
  $pins                 = {},
  $pins_hiera_merge     = false,
  $settings             = {},
  $settings_hiera_merge = false,
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
  if $proxy['host'] {
    validate_string($proxy['host'])
  }
  if $proxy['port'] {
    unless is_integer($proxy['port']) {
      fail('$proxy port must be an integer')
    }
  }
  if $proxy['https'] {
    validate_bool($proxy['https'])
  }

  $_proxy = merge($apt::proxy_defaults, $proxy)

  if is_string($sources_hiera_merge) {
    $_sources_hiera_merge = str2bool($sources_hiera_merge)
  } else {
    $_sources_hiera_merge = $sources_hiera_merge
  }
  if is_string($keys_hiera_merge) {
    $_keys_hiera_merge = str2bool($keys_hiera_merge)
  } else {
    $_keys_hiera_merge = $keys_hiera_merge
  }
  if is_string($settings_hiera_merge) {
    $_settings_hiera_merge = str2bool($settings_hiera_merge)
  } else {
    $_settings_hiera_merge = $settings_hiera_merge
  }
  if is_string($ppas_hiera_merge) {
    $_ppas_hiera_merge = str2bool($ppas_hiera_merge)
  } else {
    $_ppas_hiera_merge = $ppas_hiera_merge
  }
  if is_string($pins_hiera_merge) {
    $_pins_hiera_merge = str2bool($pins_hiera_merge)
  } else {
    $_pins_hiera_merge = $pins_hiera_merge
  }

  validate_bool($_sources_hiera_merge)
  validate_bool($_keys_hiera_merge)
  validate_bool($_settings_hiera_merge)
  validate_bool($_ppas_hiera_merge)
  validate_bool($_pins_hiera_merge)

  if $_proxy['ensure'] == 'absent' or $_proxy['host'] {
    apt::setting { 'conf-proxy':
      ensure   => $_proxy['ensure'],
      priority => '01',
      content  => template('apt/_conf_header.erb', 'apt/proxy.erb'),
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

  # manage sources if present
  if $sources {
    if $_sources_hiera_merge {
      $_sources = hiera_hash(apt::sources)
    } else {
      $_sources = $sources
    }
    validate_hash($_sources)
    create_resources('apt::source', $_sources)
  }
  # manage keys if present
  if $keys {
    if $_keys_hiera_merge {
      $_keys = hiera_hash(apt::keys)
    } else {
      $_keys = $keys
    }
    validate_hash($_keys)
    create_resources('apt::key', $_keys)
  }
  # manage ppas if present
  if $ppas {
    if $_ppas_hiera_merge {
      $_ppas = hiera_hash(apt::ppas)
    } else {
      $_ppas = $ppas
    }
    validate_hash($_ppas)
    create_resources('apt::ppa', $_ppas)
  }
  # manage settings if present
  if $settings {
    if $_settings_hiera_merge {
      $_settings = hiera_hash(apt::settings)
    } else {
      $_settings = $settings
    }
    validate_hash($_settings)
    create_resources('apt::setting', $_settings)
  }

  # manage pins if present
  if $pins {
    if $_pins_hiera_merge {
      $_pins = hiera_hash(apt::pins)
    } else {
      $_pins = $pins
    }
    validate_hash($_pins)
    create_resources('apt::pin', $_pins)
  }
}

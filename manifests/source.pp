# source.pp
# add an apt source
define apt::source(
  Optional[Variant[String, Stdlib::Compat::String]] $location                         = undef,
  Variant[String, Stdlib::Compat::String] $comment                                    = $name,
  Variant[String, Stdlib::Compat::String] $ensure                                     = present,
  Optional[Variant[String, Stdlib::Compat::String]] $release                          = undef,
  Variant[String, Stdlib::Compat::String] $repos                                      = 'main',
  Optional[Variant[Hash, Stdlib::Compat::Hash]] $include                              = {},
  Optional[Variant[String, Stdlib::Compat::String, Hash, Stdlib::Compat::Hash]] $key  = undef,
  $pin                                                                                = undef,
  Optional[Variant[String, Stdlib::Compat::String]] $architecture                     = undef,
  Boolean $allow_unsigned                                                             = false,
  Boolean $notify_update                                                              = true,
  Optional[Variant[String, Stdlib::Compat::String]] $key_server                       = undef,
  Optional[Variant[String, Stdlib::Compat::String]] $key_content                      = undef,
  Optional[Variant[String, Stdlib::Compat::String]] $key_source                       = undef,
  Optional[Boolean] $include_src                                                      = undef,
  Optional[Boolean] $include_deb                                                      = undef,
  $required_packages                                                                  = undef,
  $trusted_source                                                                     = undef,
) {

  validate_legacy(String, 'validate_string', $architecture, $comment, $location, $repos)
  validate_legacy(Boolean, 'validate_bool', $allow_unsigned)
  validate_legacy(Hash, 'validate_hash', $include)

  # This is needed for compat with 1.8.x
  include ::apt

  $_before = Apt::Setting["list-${title}"]

  if $required_packages != undef {
    deprecation('apt $required_packages', '$required_packages is deprecated and will be removed in the next major release, please use package resources instead.')
    exec { "Required packages: '${required_packages}' for ${name}":
      command     => "${::apt::provider} -y install ${required_packages}",
      logoutput   => 'on_failure',
      refreshonly => true,
      tries       => 3,
      try_sleep   => 1,
      before      => $_before,
    }
  }

  if $trusted_source != undef {
    deprecation('apt $trusted_source', '$trusted_source is deprecated and will be removed in the next major release, please use $allow_unsigned instead.')
    $_allow_unsigned = $trusted_source
  } else {
    $_allow_unsigned = $allow_unsigned
  }

  if ! $release {
    if $facts['lsbdistcodename'] {
      $_release = $facts['lsbdistcodename']
    } else {
      fail('lsbdistcodename fact not available: release parameter required')
    }
  } else {
    $_release = $release
  }

  if $ensure == 'present' and ! $location {
    fail('cannot create a source entry without specifying a location')
  }

  if $include_src != undef and $include_deb != undef {
    $_deprecated_include = {
      'src' => $include_src,
      'deb' => $include_deb,
    }
  } elsif $include_src != undef {
    $_deprecated_include = { 'src' => $include_src }
  } elsif $include_deb != undef {
    $_deprecated_include = { 'deb' => $include_deb }
  } else {
    $_deprecated_include = {}
  }

  $includes = merge($::apt::include_defaults, $_deprecated_include, $include)

  $_deprecated_key = {
    'key_server'  => $key_server,
    'key_content' => $key_content,
    'key_source'  => $key_source,
  }

  if $key {
    if is_hash($key) {
      unless $key['id'] {
        fail('key hash must contain at least an id entry')
      }
      $_key = merge($::apt::source_key_defaults, $_deprecated_key, $key)
    } else {
      validate_legacy(String, 'validate_string', $key)
      $_key = merge( { 'id' => $key }, $_deprecated_key)
    }
  }

  $header = epp('apt/_header.epp')

  $sourcelist = epp('apt/source.list.epp', {
    'comment'        => $comment,
    'includes'       => $includes,
    'architecture'   => $architecture,
    'allow_unsigned' => $_allow_unsigned,
    'location'       => $location,
    'release'        => $_release,
    'repos'          => $repos,
  })

  apt::setting { "list-${name}":
    ensure        => $ensure,
    content       => "${header}${sourcelist}",
    notify_update => $notify_update,
  }

  if $pin {
    if is_hash($pin) {
      $_pin = merge($pin, { 'ensure' => $ensure, 'before' => $_before })
    } elsif (is_numeric($pin) or is_string($pin)) {
      $url_split = split($location, '[:\/]+')
      $host      = $url_split[1]
      $_pin = {
        'ensure'   => $ensure,
        'priority' => $pin,
        'before'   => $_before,
        'origin'   => $host,
      }
    } else {
      fail('Received invalid value for pin parameter')
    }
    create_resources('apt::pin', { "${name}" => $_pin })
  }

  # We do not want to remove keys when the source is absent.
  if $key and ($ensure == 'present') {
    if is_hash($_key) {
      apt::key { "Add key: ${$_key['id']} from Apt::Source ${title}":
        ensure      => present,
        id          => $_key['id'],
        server      => $_key['server'],
        content     => $_key['content'],
        source      => $_key['source'],
        options     => $_key['options'],
        key_server  => $_key['key_server'],
        key_content => $_key['key_content'],
        key_source  => $_key['key_source'],
        before      => $_before,
      }
    }
  }
}

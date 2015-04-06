# source.pp
# add an apt source
define apt::source(
  $location       = undef,
  $comment        = $name,
  $ensure         = present,
  $release        = $::apt::xfacts['lsbdistcodename'],
  $repos          = 'main',
  $include        = {},
  $key            = undef,
  $pin            = undef,
  $architecture   = undef,
  $allow_unsigned = false,
) {
  validate_string($architecture, $comment, $location, $repos)
  validate_bool($allow_unsigned)
  validate_hash($include)

  unless $release {
    fail('lsbdistcodename fact not available: release parameter required')
  }

  if $ensure == 'present' and ! $location {
    fail('cannot create a source entry without specifying a location')
  }

  $_before = Apt::Setting["list-${title}"]
  $_include = merge($::apt::include_defaults, $include)

  if $key {
    if is_hash($key) {
      unless $key['id'] {
        fail('key hash must contain at least an id entry')
      }
      $_key = merge($::apt::source_key_defaults, $key)
    } else {
      validate_string($key)
      $_key = $key
    }
  }

  apt::setting { "list-${name}":
    ensure  => $ensure,
    content => template('apt/_header.erb', 'apt/source.list.erb'),
  }

  if $pin {
    if is_hash($pin) {
      $_pin = merge($pin, { 'ensure' => $ensure, 'before' => $_before })
    } elsif (is_numeric($pin) or is_string($pin)) {
      $url_split = split($location, '/')
      $host      = $url_split[2]
      $_pin = { 'ensure' => $ensure, 'priority'  => $pin,
                'before' => $_before, 'origin'   => $host,}
    } else {
      fail('Received invalid value for pin parameter')
    }
    create_resources('apt::pin', { "${name}" => $_pin })
  }

  # We do not want to remove keys when the source is absent.
  if $key and ($ensure == 'present') {
    if is_hash($_key) {
      apt::key { "Add key: ${_key['id']} from Apt::Source ${title}":
        ensure  => present,
        id      => $_key['id'],
        server  => $_key['server'],
        content => $_key['content'],
        source  => $_key['source'],
        options => $_key['options'],
        before  => $_before,
      }
    } else {
      apt::key { "Add key: ${_key} from Apt::Source ${title}":
        ensure => present,
        id     => $_key,
        before => $_before,
      }
    }
  }
}

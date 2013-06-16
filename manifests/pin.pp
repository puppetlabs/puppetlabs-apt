# pin.pp
# pin a release in apt, useful for unstable repositories

define apt::pin(
  $ensure     = present,
  $explanation = "${::caller_module_name}: ${name}",
  $order      = '',
  $packages   = '*',
  $priority   = 0,
  $release    = '',
  $origin     = '',
  $originator = '',
  $version    = '',
  # This parameter allows specifying a complete Apt::Pin line,
  # allowing currently unsupported pins such as "release c=main" or
  # "release a=stable, v=7.0".
  #
  # When $pin is specified, the values of $release, $origin, $originator
  # and $version are ignored.
  $pin        = ''
) {

  include apt::params

  $preferences_d = $apt::params::preferences_d

  if $order != '' and !is_integer($order) {
    fail('Only integers are allowed in the apt::pin order param')
  }

  if $pin == '' {
    if $release != '' {
      $pin = "release a=${release}"
    } elsif $origin != '' {
      $pin = "origin \"${origin}\""
    } elsif $originator != '' {
      $pin = "release o=${originator}"
    } elsif $version != '' {
      $pin = "version ${version}"
    } else {
      $pin = "release a=${name}"
    }
  }

  $path = $order ? {
    ''      => "${preferences_d}/${name}.pref",
    default => "${preferences_d}/${order}-${name}.pref",
  }
  file { "${name}.pref":
    ensure  => $ensure,
    path    => $path,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('apt/pin.pref.erb'),
  }
}

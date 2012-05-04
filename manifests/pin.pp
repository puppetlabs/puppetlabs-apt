# pin.pp
# pin a release in apt, useful for unstable repositories

define apt::pin(
  $ensure   = present,
  $packages = '*',
  $priority = 0
) {

  include apt::params

  $preferences_d = $apt::params::preferences_d

  file { "${name}.pref":
    ensure  => $ensure,
    path    => "${preferences_d}/${name}",
    owner   => root,
    group   => root,
    mode    => '0644',
    content => "# ${name}\nPackage: ${packages}\nPin: release a=${name}\nPin-Priority: ${priority}",
  }
}

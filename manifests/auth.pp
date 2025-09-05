# @summary Manages the Apt auth conf in /etc/apt/auth.conf.d/.
#
# @example Install the puppetlabs apt auth
#   apt::auth { 'puppetlabs':
#     machine  => 'apt.puppetlabs.com',
#     login    => 'apt',
#     password => 'password',
#   }
#
# @param ensure
#   Specifies whether the Apt auth file should exist. Valid options: 'present' and 'absent'.
#
# @param machine
#   The machine entry specifies the auth URI.
#
# @param login
#   The username to be used.
#
# @param password
#   The password to be used.
#

define apt::auth (
  String $ensure   = 'present',
  String $machine  = $name,
  String $login    = undef,
  String $password = undef,
) {
  $content = epp('apt/auth_conf.d.epp',
    machine  => $machine,
    login    => $login,
    password => $password
  )

  file { "${apt::auth_conf_d}/${name}.conf":
    ensure  => $ensure,
    owner   => $apt::auth_conf_owner,
    group   => 'root',
    mode    => '0600',
    content => Sensitive($content),
    notify  => Class['apt::update'],
  }
}

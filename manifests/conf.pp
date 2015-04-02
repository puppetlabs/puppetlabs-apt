define apt::conf (
  $content,
  $ensure   = present,
  $priority = '50'
) {

  include apt::params

  $apt_conf_d = $apt::params::apt_conf_d

  file { "${apt_conf_d}/${priority}${name}":
    ensure  => $ensure,
    content => template('apt/_conf_header.erb', 'apt/conf.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
  }
}

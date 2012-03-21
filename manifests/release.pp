# release.pp

class apt::release (
  $release_id
) {

  include apt::params

  file { "${apt::params::root}/apt.conf.d/01release":
    owner   => root,
    group   => root,
    mode    => '0644',
    content => "APT::Default-Release \"${release_id}\";"
  }
}

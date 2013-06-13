# force.pp
# force a package from a specific release

define apt::force(
  $release = 'testing',
  $version = false,
  $timeout = 300
) {

  $version_string = $version ? {
    false   => undef,
    default => "=${version}",
  }

  $install_check = $version ? {
    false   => "/usr/bin/aptitude search '?narrow(?narrow(?installed,?archive($release)),?name(^$name$))' | grep -q ^i",
    default => "/usr/bin/dpkg -s ${name} | grep -q 'Version: ${version}'",
  }
  exec { "/usr/bin/aptitude -y -t ${release} install ${name}${version_string}":
    unless    => $install_check,
    logoutput => 'on_failure',
    timeout   => $timeout,
  }
}

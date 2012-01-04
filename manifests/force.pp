# force.pp
# force a package from a specific release

define apt::force(
  $release = 'testing',
  $version = false
) {

  exec { "/usr/bin/aptitude -y -t ${release} install ${name}":
    unless => $version ? {
      false => "/usr/bin/dpkg -s ${name} | grep -q 'Status: install'",
      default => "/usr/bin/dpkg -s ${name} | grep -q 'Version: ${version}'"
    }
  }

}

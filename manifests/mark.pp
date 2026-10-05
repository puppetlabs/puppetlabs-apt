# @summary Manages apt-mark settings
#
# @param setting
#   Specifies the behavior of apt in case of no more dependencies installed
#   https://manpages.debian.org/stable/apt/apt-mark.8.en.html
#
define apt::mark (
  Enum['auto','manual','hold','unhold'] $setting,
) {
  if $title !~ /^[a-z0-9][a-z0-9.+\-]+$/ {
    fail("Invalid package name: ${title}")
  }

  # The piped guards must be strings: in the array form the posix provider
  # strips everything right of the pipe. $setting is an enum and the title is
  # pre-validated above.
  case $setting {
    'unhold': {
      # showhold prints the package name when held, nothing otherwise.
      $onlyif_cmd = ["/usr/bin/apt-mark showhold ${title} | grep -q ."]
      $unless_cmd = undef
    }
    'hold': {
      # Deliberately loose gate: pre-holding a not-yet-installed package is
      # legitimate, so only names dpkg has never heard of are filtered.
      $onlyif_cmd = [['/usr/bin/dpkg', '-l', $title]]
      $unless_cmd = ["/usr/bin/apt-mark showhold ${title} | grep ${title} -q"]
    }
    default: {
      # auto/manual only take effect on an installed package;
      # db:Status-Status is 'installed' solely for state ii.
      $onlyif_cmd = ["/usr/bin/dpkg-query --show --showformat '\${db:Status-Status}' ${title} | grep -qx installed"]
      $unless_cmd = ["/usr/bin/apt-mark show${setting} ${title} | grep ${title} -q"]
    }
  }

  $command = ['/usr/bin/apt-mark', $setting, $title]

  exec { "apt-mark ${setting} ${title}":
    command => $command,
    onlyif  => $onlyif_cmd,
    unless  => $unless_cmd,
  }
}

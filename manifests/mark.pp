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

  if $setting == 'unhold' {
    $unless_cmd = undef
  } else {
    $action = "show${setting}"

    # It would be ideal if we could break out this command in to an array of args, similar
    # to $onlyif_cmd and $command. However, in this case it wouldn't work as expected due
    # to the inclusion of a pipe character.
    # When passed to the exec function, the posix provider will strip everything to the right of the pipe,
    # causing the command to return a full list of packages for the given action.
    # The trade off is to use an interpolated string knowing that action is built from an enum value and
    # title is pre-validated.
    $unless_cmd = ["/usr/bin/apt-mark ${action} ${title} | grep ${title} -q"]
  }

  $onlyif_cmd = [['/usr/bin/dpkg', '-l', $title]]
  $command = ['/usr/bin/apt-mark', $setting, $title]

  exec { "apt-mark ${setting} ${title}":
    command => $command,
    onlyif  => $onlyif_cmd,
    unless  => $unless_cmd,
  }
}

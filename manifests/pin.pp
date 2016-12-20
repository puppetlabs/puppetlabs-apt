# pin.pp
# pin a release in apt, useful for unstable repositories

define apt::pin(
  Optional[Enum['file', 'present', 'absent']] $ensure                             = present,
  Optional[Variant[String, Stdlib::Compat::String]] $explanation                  = undef,
  Variant[Integer,  Stdlib::Compat::Integer] $order                               = 50,
  Variant[String, Stdlib::Compat::String, Stdlib::Compat::Array, Array] $packages = '*',
  Variant[Numeric, String, Stdlib::Compat::String] $priority                      = 0,
  Optional[Variant[String, Stdlib::Compat::String]] $release                      = '', # a=
  Optional[Variant[String, Stdlib::Compat::String]] $origin                       = '',
  Optional[Variant[String, Stdlib::Compat::String]] $version                      = '',
  Optional[Variant[String, Stdlib::Compat::String]] $codename                     = '', # n=
  Optional[Variant[String, Stdlib::Compat::String]] $release_version              = '', # v=
  Optional[Variant[String, Stdlib::Compat::String]] $component                    = '', # c=
  Optional[Variant[String, Stdlib::Compat::String]] $originator                   = '', # o=
  Optional[Variant[String, Stdlib::Compat::String]] $label                        = '',  # l=
) {

  if $explanation {
    $_explanation = $explanation
  } else {
    if defined('$caller_module_name') { # strict vars check
      $_explanation = "${caller_module_name}: ${name}"
    } else {
      $_explanation = ": ${name}"
    }
  }

  $pin_release_array = [
    $release,
    $codename,
    $release_version,
    $component,
    $originator,
    $label    ,
  ]
  $pin_release = join($pin_release_array, '')

  # Read the manpage 'apt_preferences(5)', especially the chapter
  # 'The Effect of APT Preferences' to understand the following logic
  # and the difference between specific and general form
  if is_array($packages) {
    $packages_string = join($packages, ' ')
  } else {
    $packages_string = $packages
  }

  if $packages_string != '*' { # specific form
    if ( $pin_release != '' and ( $origin != '' or $version != '' )) or
      ( $version != '' and ( $pin_release != '' or $origin != '' )) {
      fail('parameters release, origin, and version are mutually exclusive')
    }
  } else { # general form
    if $version != '' {
      fail('parameter version cannot be used in general form')
    }
    if ( $pin_release != '' and $origin != '' ) {
      fail('parameters release and origin are mutually exclusive')
    }
  }

  # According to man 5 apt_preferences:
  # The files have either no or "pref" as filename extension
  # and only contain alphanumeric, hyphen (-), underscore (_) and period
  # (.) characters. Otherwise APT will print a notice that it has ignored a
  # file, unless that file matches a pattern in the
  # Dir::Ignore-Files-Silently configuration list - in which case it will
  # be silently ignored.
  $file_name = regsubst($title, '[^0-9a-z\-_\.]', '_', 'IG')

  $headertmp = epp('apt/_header.epp')

  $pinpreftmp = epp('apt/pin.pref.epp', {
      'name'            => $name,
      'pin_release'     => $pin_release,
      'release'         => $release,
      'codename'        => $codename,
      'release_version' => $release_version,
      'component'       => $component,
      'originator'      => $originator,
      'label'           => $label,
      'version'         => $version,
      'origin'          => $origin,
      'explanation'     => $_explanation,
      'packages_string' => $packages_string,
      'priority'        => $priority,
  })

  apt::setting { "pref-${file_name}":
    ensure        => $ensure,
    priority      => $order,
    content       => "${headertmp}${pinpreftmp}",
    notify_update => false,
  }
}

# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @example
#   apt::source_deb822 { 'namevar': }
define apt::source_deb822 (
  String $comment = $name,
  Boolean $enabled = true,
  Array[Enum['deb','deb-src'], 1, 2] $types = ['deb'],
  Boolean $notify_update = true,
  Enum['present','absent'] $ensure = 'present',
  Optional[Array[String]] $uris = undef,
  Optional[Array[String]] $suites = undef,
  Optional[Array[String]] $components = undef,
  Optional[Array[String]] $architectures = undef,
  Optional[Boolean] $allow_insecure = undef,
  Optional[Boolean] $repo_trusted = undef,
  Optional[Variant[Array[Stdlib::AbsolutePath],String]] $signed_by = undef,
  Optional[Boolean] $check_valid_until = undef,
) {
  case $ensure {
    'present': {
      $header = epp('apt/_header.epp')
      $source_content = epp('apt/source_deb822.epp', delete_undef_values({
            'uris'              => $uris,
            'suites'            => $suites,
            'components'        => $components,
            'types'             => $types,
            'comment'           => $comment,
            'enabled'           => $enabled ? { true => 'yes', false => 'no' },
            'architectures'     => $architectures,
            'allow_insecure'    => $allow_insecure ? { true => 'yes', false => 'no', default => undef },
            'repo_trusted'      => $repo_trusted ? { true => 'yes', false => 'no', default => undef },
            'check_valid_until' => $check_valid_until ? { true => 'yes', false => 'no', default => undef },
            'signed_by'         => $signed_by,
          }
        )
      )
    }
    'absent': {
      $header = undef
      $source_content = undef
    }
  }

  apt::setting { "source-${name}":
    ensure        => $ensure,
    content       => "${header}${source_content}",
    notify_update => $notify_update,
  }
}

# @summary Manage deb822 formatted APT sources under `/etc/apt/sources.list.d`
#
# @example Manage the Puppetlabs repo
#   apt::source_deb822 { 'Puppetlabs-puppet':
#     comment    => 'Manage the puppetlabs repo',
#     enabled    => true,
#     types      => ['deb'],
#     uris       => ['http://apt.puppet.com'],
#     suites     => ['jammy'],
#     components => ['puppet8'],
#     signed_by  => ['/etc/apt/keyrings/linuxembl-ebi.gpg'],
#   }
#
# @example Ensure absence of a repo
#   apt::source_deb822 { 'testing123':
#     ensure => 'absent',
#   }
#
# @param notify_update 
#   Specifies whether to trigger an `apt-get update` run.
#
# @param ensure
#   Specifies whether the Apt source file should exist.
#
# @param enabled
#   Enable or Disable the APT source.
#
# @param comment
#   Provide a comment to the APT source file.
#
# @param types
#   The package types this source manages.
#
# @param uris
#   A list of URIs for the APT source.
#
# @param suites
#   A list of suites for the APT source ('jammy-updates', 'bookworm', 'stable', etc.).
#
# @param components
#   A list of components for the APT source ('main', 'contrib', 'non-free', etc.).
#
# @param architectures
#   A list of supported architectures for the APT source ('amd64', 'i386', etc.).
#
# @param allow_insecure
#   Specifies whether to allow downloads from insecure repositories.
#
# @param repo_trusted
#   Consider the APT source trusted, even if authentication checks fail.
#
# @param check_valid_until
#   Specifies whether to check if the package release date is valid.
#
# @param signed_by
#   Absolute path to a file containing the PGP keyring used to sign this repository.
#
define apt::source_deb822 (
  Enum['present','absent'] $ensure = 'present',
  Boolean $notify_update = true,
  Boolean $enabled = true,
  String $comment = $name,
  Array[Enum['deb','deb-src'], 1, 2] $types = ['deb'],
  Optional[Array[String]] $uris = undef,
  Optional[Array[String]] $suites = undef,
  Optional[Array[String]] $components = undef,
  Optional[Array[String]] $architectures = undef,
  Optional[Boolean] $allow_insecure = undef,
  Optional[Boolean] $repo_trusted = undef,
  Optional[Boolean] $check_valid_until = undef,
  Optional[Variant[Array[Stdlib::AbsolutePath],String]] $signed_by = undef,
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
    default: {
      fail('Unexpected value for $ensure parameter.')
    }
  }

  apt::setting { "source-${name}":
    ensure        => $ensure,
    content       => "${header}${source_content}",
    notify_update => $notify_update,
  }
}

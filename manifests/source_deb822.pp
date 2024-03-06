# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @example
#   apt::source_deb822 { 'namevar': }
define apt::source_deb822 (
  Array[String] $uris,
  Array[String] $suites,
  Array[String] $components,
  Array[Enum['deb','deb-src'], 1, 2] $types = ['deb'],
  Enum['present','absent'] $ensure = 'present',
  String $comment = $name,
  Boolean $enabled = true,
  Boolean $notify_update = true,
  Optional[Array[String]] $architectures = undef,
  Optional[Boolean] $allow_insecure = undef,
  Optional[Boolean] $trusted = undef,
  Optional[Variant[Array[Stdlib::AbsolutePath], String]] $signed_by = undef,
  Optional[Boolean] $check_valid_until = undef,
  Optional[Hash] $options = undef
) {
  $header = epp('apt/_header.epp')
  $source_content = epp('apt/source_deb822.epp')

  apt::setting { "source-${name}":
    ensure        => $ensure,
    content       => "${header}${source_content}",
    notify_update => $notify_update,
  }
}

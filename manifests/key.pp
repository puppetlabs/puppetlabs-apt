# == Define: apt::key
define apt::key (
    String $id                           = $title,
    Enum['present', 'absent'] $ensure    = present,
    Optional[String] $content            = undef,
    Optional[String] $source             = undef,
    String $server                       = $::apt::keyserver,
    Optional[String] $options            = undef,
    ) {

  validate_re($id, ['\A(0x)?[0-9a-fA-F]{8}\Z', '\A(0x)?[0-9a-fA-F]{16}\Z', '\A(0x)?[0-9a-fA-F]{40}\Z'])

  if $source {
    validate_re($source, ['\Ahttps?:\/\/', '\Aftp:\/\/', '\A\/\w+'])
  }

  if $server {
    validate_re($server,['\A((hkp|http|https):\/\/)?([a-z\d])([a-z\d-]{0,61}\.)+[a-z\d]+(:\d{2,5})?$'])
  }

  case $ensure {
    present: {
      if defined(Anchor["apt_key ${id} absent"]){
        fail("key with id ${id} already ensured as absent")
      }

      if !defined(Anchor["apt_key ${id} present"]) {
        apt_key { $title:
          ensure  => $ensure,
          id      => $id,
          source  => $source,
          content => $content,
          server  => $server,
          options => $options,
        } -> anchor { "apt_key ${id} present": }
      }
    }

    absent: {
      if defined(Anchor["apt_key ${id} present"]){
        fail("key with id ${id} already ensured as present")
      }

      if !defined(Anchor["apt_key ${id} absent"]){
        apt_key { $title:
          ensure  => $ensure,
          id      => $id,
          source  => $source,
          content => $content,
          server  => $server,
          options => $options,
        } -> anchor { "apt_key ${id} absent": }
      }
    }

    default: {
      fail "Invalid 'ensure' value '${ensure}' for apt::key"
    }
  }
}

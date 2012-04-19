# source.pp
# add an apt source

define apt::source(
  $ensure = present,
  $location = '',
  $release = $lsbdistcodename,
  $repos = 'main',
  $include_src = true,
  $required_packages = false,
  $key = false,
  $key_server = 'keyserver.ubuntu.com',
  $key_content = false,
  $key_source  = false,
  $pin = false
) {

  include apt::params

  if $release == undef {
    fail('lsbdistcodename fact not available: release parameter required')
  }
  
  case $ensure {
    present: { 
      file { "${name}.list":
        ensure  => file,
        path    => "${apt::params::root}/sources.list.d/${name}.list",
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template("${module_name}/source.list.erb"),
      }
    }
    absent: {
      file { "${name}.list":
        ensure  => absent,
        path    => "${apt::params::root}/sources.list.d/${name}.list",
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template("${module_name}/source.list.erb"),
      }
    }
    default: { fail "Invalid 'ensure' value '${ensure}' for apt::source" }
  }

  if $pin != false {
    apt::pin { $release: priority => $pin } -> File["${name}.list"]
  }

  exec { "${name} apt update":
    command     => "${apt::params::provider} update",
    subscribe   => File["${name}.list"],
    refreshonly => true,
  }

  if $required_packages != false {
    exec { "Required packages: '${required_packages}' for ${name}":
      command     => "${apt::params::provider} -y install ${required_packages}",
      subscribe   => File["${name}.list"],
      refreshonly => true,
    }
  }

  if $key != false {
    apt::key { "Add key: ${key} from Apt::Source ${title}":
      ensure      => present,
      key         => $key,
      key_server  => $key_server,
      key_content => $key_content,
      key_source  => $key_source,
      before      => File["${name}.list"],
    }
  }
}

# source.pp
# add an apt source

define apt::source(
  $location = '',
  $release = $lsbdistcodename,
  $repos = 'main',
  $include_src = true,
  $required_packages = false,
  $key = false,
  $key_server = 'keyserver.ubuntu.com',
  $pin = false,
  $key_content = false
) {

  include apt::params

  if ! $release {
    fail("lsbdistcodename fact not available: release parameter required")
  }

  file { "${name}.list":
    path => "${apt::params::root}/sources.list.d/${name}.list",
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    content => template("apt/source.list.erb"),

  }

  if $pin != false {
    apt::pin { "${release}": priority => "${pin}" } -> File["${name}.list"]
  }

  exec { "${name} apt update":
    command => "${apt::params::provider} update",
    subscribe => File["${name}.list"],
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
    if $key_content {
      exec { "Add key: ${key} from content for ${name}":
        command => "/bin/echo '${key_content}' | /usr/bin/apt-key add -",
        unless => "/usr/bin/apt-key list | /bin/grep '${key}'",
        before => File["${name}.list"],
      }
    } else {
      exec { "Add key: ${key} from ${key_server} for ${name}":
        command => "/usr/bin/apt-key adv --keyserver ${key_server} --recv-keys ${key}",
        unless => "/usr/bin/apt-key list | /bin/grep ${key}",
        before => File["${name}.list"],
      }
    }
  }
}

# source.pp
# add an apt source

define apt::source(
  $location = '',
  $release = 'karmic',
  $repos = 'main',
  $include_src = true,
  $required_packages = false,
  $key = false,
  $key_server = 'keyserver.ubuntu.com',
  $pin = false,
  $key_content = false
) {

  include apt::params


  file { "${name}.list":
    name => "${apt::params::root}/sources.list.d/${name}.list",
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
    exec { "${apt::params::provider} -y install ${required_packages}":
      subscribe => File["${name}.list"],
      refreshonly => true,
    }
  }

  if $key != false {
    if $key_content {
      exec { "Add key: ${key} from content":
        command => "/bin/echo '${key_content}' | /usr/bin/apt-key add -",
        unless => "/usr/bin/apt-key list | /bin/grep '${key}'",
        before => File["${name}.list"],
      } 
    } else {
      exec { "/usr/bin/apt-key adv --keyserver ${key_server} --recv-keys ${key}":
        unless => "/usr/bin/apt-key list | /bin/grep ${key}",
        before => File["${name}.list"],
      }
    }
  }
}

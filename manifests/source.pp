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
  $key_content = false,
  $key_source  = false,
  $pin = false
) {

  include apt::params

  if $release == undef {
    fail('lsbdistcodename fact not available: release parameter required')
  }

  $sourcelist_path = "${apt::params::sources_list_d}/${name}.list"
  $update_options  = join([
    "-o Dir::Etc::SourceList=${sourcelist_path}",
    '-o Dir::Etc::SourceParts=/dev/null',
    '--no-list-cleanup',
    ], ' ')

  file { "${name}.list":
    ensure  => file,
    path    => $sourcelist_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("apt/source.list.erb"),
  }

  exec { "${name} apt update":
    command     => "${apt::params::provider} update ${update_options}",
    subscribe   => File["${name}.list"],
    refreshonly => true,
  }

  if $pin != false {
    apt::pin { "${release}": priority => "${pin}" } -> File["${name}.list"]
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

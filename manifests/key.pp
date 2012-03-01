define apt::key (
  $key = $title,
  $ensure = present,
  $key_content = false,
  $key_source = false,
  $key_server = "keyserver.ubuntu.com"
) {

  include apt::params

  if $key_content {
    $method = "content"
  } elsif $key_source {
    $method = "source"
  } elsif $key_server {
    $method = "server"
  }

  # This is a hash of the parts of the key definition that we care about.
  # It is used as a unique identifier for this instance of apt::key. It gets
  # hashed to ensure that the resource name doesn't end up being pages and
  # pages (e.g. in the situation where key_content is specified).
  $digest = sha1("${key}/${key_content}/${key_source}/${key_server}/")

  # Allow multiple ensure => present for the same key to account for many
  # apt::source resources that all reference the same key.
  case $ensure {
    present: {
      if defined(Exec["apt::key $key absent"]) {
        fail ("Cannot ensure Apt::Key[$key] present; $key already ensured absent")
      } elsif !defined(Exec["apt::key $key present"]) {
        # this is a marker to ensure we don't simultaneously define a key
        # ensure => absent AND ensure => present
        exec { "apt::key $key present":
          path   => "/",
          onlyif => "/bin/false",
          noop   => true;
        }
      }
      if !defined(Exec[$digest]) {
        exec { $digest:
          path    => "/bin:/usr/bin",
          unless  => "/usr/bin/apt-key list | /bin/grep '${key}'",
          command => $method ? {
            "content" => "echo '${key_content}' | /usr/bin/apt-key add -",
            "source"  => "wget -q '${key_source}' -O- | apt-key add -",
            "server"  => "apt-key adv --keyserver '${key_server}' --recv-keys '${key}'",
          };
        }
      }
    }
    absent: {
      if defined(Exec["apt::key $key present"]) {
        fail ("Cannot ensure Apt::Key[$key] absent; $key already ensured present")
      }
      exec { "apt::key $key absent":
        path    => "/bin:/usr/bin",
        onlyif  => "apt-key list | grep '$key'",
        command => "apt-key del '$key'",
        user    => "root",
        group   => "root",
      }
    }
    default: {
      fail "Invalid 'ensure' value '$ensure' for aptkey"
    }
  }
}

# Allow APT to use repos served over HTTPS
class apt::transport_https (
  $ensure = 'present'
) {
  if $ensure !~ /^(present|absent|purged|held|latest)$/ {
    fail('ensure must be either present, absent, purged, held, or latest')
  }

  package { ['apt-transport-https', 'ca-certificates']:
    ensure => $ensure,
  }
}

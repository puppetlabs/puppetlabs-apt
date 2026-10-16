# @summary An ASCII-armored public key, for embedding in a deb822 source.
type Apt::Source_key = Pattern[/\A-----BEGIN PGP PUBLIC KEY BLOCK-----\n(?:[A-Za-z0-9-]+:[^\r\n]*\n)*(?:[A-Za-z0-9+\/=]*\n)+-----END PGP PUBLIC KEY BLOCK-----\n?\z/]

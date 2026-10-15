# @summary An absolute keyring path or full fingerprint, optionally excluding subkeys.
type Apt::Source_signer = Pattern[/\A\/[^\s,\[\]#!=]+\z/, /\A[0-9A-Fa-f]{40}!?\z/]

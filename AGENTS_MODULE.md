# AI Agent Instructions for the apt Module

These instructions supplement [AGENTS.md](AGENTS.md). Follow both files when
working in this repository.

## Purpose and code layout

This is the `puppetlabs-apt` module for managing APT sources, repository keys,
preferences, configuration, and authentication on Debian and Ubuntu.
Use `metadata.json` for the current supported releases and dependency ranges;
old examples or test fixtures do not establish platform support.

- `manifests/init.pp` defines the main `apt` class, shared paths, purge
  settings, and resource hashes used to configure the module through Hiera.
- `manifests/source.pp` manages repository entries; `manifests/setting.pp`
  manages the underlying configuration files and update notifications.
- `manifests/update.pp` manages the `apt_update` exec.
- `templates/` contains EPP templates, including separate templates for
  one-line `.list` sources and deb822 `.sources` files.
- `types/` contains the module's Puppet data types.
- `data/` and `hiera.yaml` provide common and platform-specific defaults.
- `lib/facter/` contains APT facts; `lib/puppet/type/apt_key.rb` and
  `lib/puppet/provider/apt_key/` implement legacy key management.
- `tasks/` contains the module's task implementation and metadata.

## Resource relationships and updates

- Preserve the initialization provided by the main `apt` class. Check how a
  defined resource includes or depends on it before changing shared paths or
  defaults.
- Preserve `notify_update` behavior and notifications to `Class['apt::update']`
  and `Exec['apt_update']`. Do not replace notification-driven updates with
  unconditional `apt-get update` commands.
- Preserve the configured update frequency and its use of the
  `apt_update_last_success` fact. Explicit `always` updates intentionally run
  on every Puppet run; do not treat that setting as an idempotency defect.
- Packages installed from a newly added source or PPA in the same Puppet run
  must depend on both that source or PPA and `Class['apt::update']`, as
  documented in the README. Avoid broad resource collectors that introduce
  dependency cycles. The module is not designed to be split across run stages.
- Keep purge behavior opt-in. Do not remove unmanaged sources, preferences,
  configuration, or keyrings as a side effect of unrelated changes.

## Source formats, trust, and credentials

- Preserve both `.list` and deb822 `.sources` support and the default source
  format. When adding a source option, review its data type, manifest
  validation, both templates, documentation, and tests.
- Preserve APT-version checks based on `apt_version`, including the existing
  behavior when the fact is unavailable. Test version boundaries and reject
  unsupported options explicitly rather than silently dropping them.
- Preserve distinctions between omitted options and explicit `false` or zero
  values. Follow the existing format-specific serialization and input
  validation, including protection against injected lines or source options.
- Prefer `apt::keyring` for new key-management examples. Keep the legacy
  `apt::key` and `apt_key` interfaces compatible; deprecation is not permission
  to remove them outside a major release.
- Preserve validation for mutually exclusive key inputs and the handling of
  keyring paths, fingerprint selectors, and inline deb822 public keys. Do not
  weaken repository signature or validity checking by default.
- Preserve restrictive authentication-file permissions and sensitive content
  handling. Do not expose repository or proxy credentials in logs or fixtures.
- Respect configurable paths from the `apt` class rather than introducing
  hard-coded `/etc/apt` paths where configurable equivalents exist.

## Tests and documentation

Use the PDK commands in `AGENTS.md`. Place class tests in `spec/classes/`,
defined-resource tests in `spec/defines/`, fact and type/provider tests in
`spec/unit/`, and Litmus acceptance tests in `spec/acceptance/`.

For source changes, follow the patterns in
`spec/defines/source_options_spec.rb` and the compatibility specs. Cover both
formats where applicable, rendered output, invalid inputs, absence/removal,
version-dependent behavior, and relevant resource relationships.
For acceptance coverage, `spec/acceptance/source_options_spec.rb` demonstrates
a local signed archive that validates actual APT behavior without depending
on a public repository. Preserve test isolation, cleanup, and idempotent
application.

Acceptance tests run through `.github/workflows/ci.yml`. Dispatch only after
the trust and ref checks required by `AGENTS.md`, with maintainer confirmation
that the published branch is trusted. Then use:

```shell
gh workflow run ci.yml --ref <branch>
gh run list --workflow ci.yml --branch <branch> --event workflow_dispatch
gh run watch <run-id> --exit-status
```

Select the run corresponding to the requested branch and dispatch. Required
permissions, secrets, and infrastructure must be available. Fork acceptance
runs are gated by the `allowed-for-ci` label and maintainer approval; do not
bypass those safeguards or expose secrets to untrusted code.

Document public behavior in `README.md` and the relevant Puppet Strings
comments. Regenerate `REFERENCE.md` using the command in the README when its
source documentation changes; do not edit the generated reference directly.

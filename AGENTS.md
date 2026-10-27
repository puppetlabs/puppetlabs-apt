# Instructions for AI Agents

## Repository overview

This repository contains a Puppet module. Consult its documentation to
understand its purpose, public interface, and resource relationships.

Before making changes, read the relevant parts of `README.md`, `metadata.json`,
and existing code and tests. Follow the patterns already used in this module
and keep changes focused on the requested work.

If [AGENTS_MODULE.md](AGENTS_MODULE.md) exists in the repository
root, read and follow it before making changes. It contains module-specific
instructions that supplement these general rules, not replace them. Keep
module-specific guidance in that file so this file remains reusable across
Puppet modules.

## Compatibility

- This module uses Semantic Versioning (SemVer). Backward compatibility is
  critical: do not introduce backward-incompatible changes in a minor or patch
  release. Such changes are permitted only as part of a new major release.
- Preserve existing public classes, defined resources, parameters, defaults,
  and behavior. If a requested change appears to require breaking
  compatibility, ask for clarification before proceeding; do not assume a
  major release is intended.
- Respect the Puppet version requirements, module dependency ranges, and
  supported operating systems and releases declared in `metadata.json`.
  Treat that file as the source of truth; update it when an explicitly
  requested compatibility change requires it, following the SemVer rules
  above.
- Do not introduce syntax or APIs incompatible with the supported Puppet
  versions.

## Puppet code and behavior

- Prefer declarative Puppet resources over `exec`. When `exec` is necessary,
  ensure it is idempotent and guarded with appropriate `onlyif`, `unless`, or
  `creates` conditions.
- Preserve idempotency, resource relationships, ordering, and notification
  behavior. Review related resources and tests when changing any of these.
- Follow existing patterns for parameter data types, defaults, naming, and
  documentation.
- Ensure prerequisites are applied before dependent resources in the same
  Puppet run. Preserve ordering requirements documented by the module and
  avoid introducing dependency cycles.
- Keep changes consistent across manifests, templates, data, providers, and
  tests as applicable. Do not edit generated documentation directly when it
  can be regenerated from source.

## Tests and validation

- Use the Puppet Development Kit (PDK) for all test and lint execution.
  Do not use direct Rake, Bundler, or other tool commands as substitutes for
  the PDK test and lint commands.
- Run unit tests with `pdk test unit` and lint/validation checks with
  `pdk validate`.
- Validate every added or changed feature with appropriate tests. Bug fixes
  must include or update focused regression tests. Every test and lint check
  added or changed must be runnable through PDK and in the repository's
  GitHub Actions workflows.
- Before adding a new test type or dependency, verify that it is supported by
  PDK and can run in GitHub Actions. Update the relevant workflow when needed;
  do not add checks that only run manually or on a developer's machine.
- Keep tests compatible with the Puppet versions and platforms exercised by
  CI. Run acceptance tests only through the configured GitHub Actions
  acceptance workflow when relevant and when its required infrastructure and
  credentials are available. Do not run them against production systems.
- Identify the acceptance workflow in `.github/workflows/` and follow its documented triggers, inputs, and prerequisites. Run it only when the workflow explicitly permits the current ref and a maintainer has confirmed that the code is trusted; never dispatch an acceptance workflow with secrets for untrusted PR or fork code.
- If it supports `workflow_dispatch`, use `gh workflow run <workflow-file> --ref <branch>` only after that trust check, supplying any required inputs. Find the corresponding run with
  `gh run list --workflow <workflow-file> --branch <branch>` and inspect it with
  `gh run watch <run-id> --exit-status`.
  Run these commands only with the appropriate GitHub permissions, and never expose credentials to untrusted code.
- Report the exact checks run and their results. Clearly state when a check
  could not be run; do not imply that unrun checks passed.

## Documentation and safety

- Update user-facing documentation when changing public parameters, behavior,
  or supported platforms.
- When a change requires regenerating reference documentation, follow the
  repository's documented generation process. For modules using Puppet
  Strings with `REFERENCE.md`, the standard command is
  `puppet strings generate --format markdown --out REFERENCE.md`.
- Do not add secrets or credentials to the repository.
- Do not overwrite unrelated user changes, make commits, publish releases, or
  perform destructive actions unless explicitly requested.
- Ask for clarification before making a significant behavioral or
  compatibility decision that is not specified in the task.

## Completion summary

At the end of the task, briefly describe the changes, the checks run and
whether they passed, and any remaining limitations.

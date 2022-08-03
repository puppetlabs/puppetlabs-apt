# Change log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v8.5.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.5.0) (2022-08-03)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.4.1...v8.5.0)

### Added

- \(GH-1038\) add support for `check-valid-until` configuration [\#1042](https://github.com/puppetlabs/puppetlabs-apt/pull/1042) ([david22swan](https://github.com/david22swan))

## [v8.4.1](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.4.1) (2022-06-20)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.4.0...v8.4.1)

### Fixed

- \(ISSUE-1036\) Conditional `gnupg` include added to init.pp [\#1039](https://github.com/puppetlabs/puppetlabs-apt/pull/1039) ([david22swan](https://github.com/david22swan))

## [v8.4.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.4.0) (2022-06-06)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.3.0...v8.4.0)

### Changed

- \(GH-iac-334\) Remove code specific to unsupported OSs [\#1024](https://github.com/puppetlabs/puppetlabs-apt/pull/1024) ([david22swan](https://github.com/david22swan))

### Added

- enable allow-insecure for apt::source defined types, includes new tes… [\#1014](https://github.com/puppetlabs/puppetlabs-apt/pull/1014) ([hesco](https://github.com/hesco))

### Fixed

- pdksync - \(GH-iac-334\) Remove Support for Ubuntu 14.04 [\#1023](https://github.com/puppetlabs/puppetlabs-apt/pull/1023) ([david22swan](https://github.com/david22swan))
- pdksync - \(GH-iac-334\) Remove Support for Ubuntu 16.04 [\#1022](https://github.com/puppetlabs/puppetlabs-apt/pull/1022) ([david22swan](https://github.com/david22swan))
- \(MODULES-11301\) Don't install gnupg if not needed [\#1020](https://github.com/puppetlabs/puppetlabs-apt/pull/1020) ([simondeziel](https://github.com/simondeziel))
- Use fact\(\) function for all os.distro.\* facts [\#1017](https://github.com/puppetlabs/puppetlabs-apt/pull/1017) ([root-expert](https://github.com/root-expert))
- \(maint\) Fix resource ordering when apt-transport-https is needed [\#1015](https://github.com/puppetlabs/puppetlabs-apt/pull/1015) ([smortex](https://github.com/smortex))
- Omit empty options in source.list template to fix MODULES-11174 [\#1013](https://github.com/puppetlabs/puppetlabs-apt/pull/1013) ([mpdude](https://github.com/mpdude))
- Replace `arm64` for `aarch64` in `::apt::source` [\#1012](https://github.com/puppetlabs/puppetlabs-apt/pull/1012) ([mpdude](https://github.com/mpdude))
- Fixed gpg file for Ubuntu versions 21.04 and later. [\#1011](https://github.com/puppetlabs/puppetlabs-apt/pull/1011) ([Conzar](https://github.com/Conzar))
- \(MODULES-10763\) Remove frequency collector [\#1010](https://github.com/puppetlabs/puppetlabs-apt/pull/1010) ([LTangaF](https://github.com/LTangaF))

### UNCATEGORIZED PRS; LABEL THEM ON GITHUB

- Release prep v8.4.0 [\#1035](https://github.com/puppetlabs/puppetlabs-apt/pull/1035) ([LukasAud](https://github.com/LukasAud))

## [v8.3.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.3.0) (2021-10-04)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.2.0...v8.3.0)

### Added

- \(MODULES-11173\) Add per-host overrides for apt::proxy [\#1007](https://github.com/puppetlabs/puppetlabs-apt/pull/1007) ([maturnbull](https://github.com/maturnbull))

### Fixed

- pdksync - \(IAC-1598\) - Remove Support for Debian 8 [\#1008](https://github.com/puppetlabs/puppetlabs-apt/pull/1008) ([david22swan](https://github.com/david22swan))

## [v8.2.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.2.0) (2021-08-25)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.1.0...v8.2.0)

### Added

- \(maint\) Add support for Debian 11 [\#1001](https://github.com/puppetlabs/puppetlabs-apt/pull/1001) ([smortex](https://github.com/smortex))

### Fixed

- \(main\) Allow stdlib 8.0.0 [\#1000](https://github.com/puppetlabs/puppetlabs-apt/pull/1000) ([smortex](https://github.com/smortex))

## [v8.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.1.0) (2021-07-26)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.0.2...v8.1.0)

### Added

- \[MODULES-9695\] - Add support for signed-by in source entries [\#991](https://github.com/puppetlabs/puppetlabs-apt/pull/991) ([johanfleury](https://github.com/johanfleury))

### Fixed

- apt::source: pass the weak\_ssl param to apt::key [\#993](https://github.com/puppetlabs/puppetlabs-apt/pull/993) ([kenyon](https://github.com/kenyon))
- \(IAC-1597\) Increasing MAX\_RETRY\_COUNT [\#987](https://github.com/puppetlabs/puppetlabs-apt/pull/987) ([pmcmaw](https://github.com/pmcmaw))

## [v8.0.2](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.0.2) (2021-03-29)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.0.1...v8.0.2)

### Fixed

- \(MODULES-10971\) - Ensure `apt::keyserver` is considered when creating a default apt:source [\#981](https://github.com/puppetlabs/puppetlabs-apt/pull/981) ([david22swan](https://github.com/david22swan))
- \(IAC-1497\) - Removal of unsupported `translate` dependency [\#979](https://github.com/puppetlabs/puppetlabs-apt/pull/979) ([david22swan](https://github.com/david22swan))

## [v8.0.1](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.0.1) (2021-03-15)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.0.0...v8.0.1)

### Fixed

- MODULES-10956 remove redundant code in provider apt\_key [\#973](https://github.com/puppetlabs/puppetlabs-apt/pull/973) ([moritz-makandra](https://github.com/moritz-makandra))

## [v8.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.0.0) (2021-03-01)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.7.1...v8.0.0)

### Changed

- pdksync - Remove Puppet 5 from testing and bump minimal version to 6.0.0 [\#969](https://github.com/puppetlabs/puppetlabs-apt/pull/969) ([carabasdaniel](https://github.com/carabasdaniel))

## [v7.7.1](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.7.1) (2021-02-15)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.7.0...v7.7.1)

### Fixed

- Use modern os facts [\#964](https://github.com/puppetlabs/puppetlabs-apt/pull/964) ([kenyon](https://github.com/kenyon))

## [v7.7.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.7.0) (2020-12-08)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.6.0...v7.7.0)

### Added

- pdksync - \(feat\) - Add support for Puppet 7 [\#958](https://github.com/puppetlabs/puppetlabs-apt/pull/958) ([daianamezdrea](https://github.com/daianamezdrea))
- Make auth.conf contents Sensitive [\#953](https://github.com/puppetlabs/puppetlabs-apt/pull/953) ([suchpuppet](https://github.com/suchpuppet))

## [v7.6.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.6.0) (2020-09-15)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.5.0...v7.6.0)

### Added

- \(MODULES-10804\) option to force purge source.lists file [\#948](https://github.com/puppetlabs/puppetlabs-apt/pull/948) ([sheenaajay](https://github.com/sheenaajay))

### Fixed

- \(IAC-978\) - Removal of inappropriate terminology [\#947](https://github.com/puppetlabs/puppetlabs-apt/pull/947) ([david22swan](https://github.com/david22swan))

## [v7.5.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.5.0) (2020-08-12)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.4.2...v7.5.0)

### Added

- pdksync - \(IAC-973\) - Update travis/appveyor to run on new default branch main [\#940](https://github.com/puppetlabs/puppetlabs-apt/pull/940) ([david22swan](https://github.com/david22swan))
- patch-acng-ssl-support [\#938](https://github.com/puppetlabs/puppetlabs-apt/pull/938) ([mdklapwijk](https://github.com/mdklapwijk))
- \(IAC-746\) - Add ubuntu 20.04 support [\#936](https://github.com/puppetlabs/puppetlabs-apt/pull/936) ([david22swan](https://github.com/david22swan))

### Fixed

- \(MODULES-10763\) loglevel won't affect reports [\#942](https://github.com/puppetlabs/puppetlabs-apt/pull/942) ([gguillotte](https://github.com/gguillotte))

## [v7.4.2](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.4.2) (2020-05-14)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.4.1...v7.4.2)

### Fixed

- fix apt-mark syntax [\#927](https://github.com/puppetlabs/puppetlabs-apt/pull/927) ([tryfunc](https://github.com/tryfunc))
- Do not specify file modes unless relevant [\#923](https://github.com/puppetlabs/puppetlabs-apt/pull/923) ([anarcat](https://github.com/anarcat))

## [v7.4.1](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.4.1) (2020-03-10)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.4.0...v7.4.1)

### Fixed

- \(MODULES-10583\) Revert "MODULES-10548: make files readonly" [\#920](https://github.com/puppetlabs/puppetlabs-apt/pull/920) ([carabasdaniel](https://github.com/carabasdaniel))

## [v7.4.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.4.0) (2020-03-03)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.3.0...v7.4.0)

### Added

- Add 'include' param to apt::backports [\#910](https://github.com/puppetlabs/puppetlabs-apt/pull/910) ([paladox](https://github.com/paladox))
- pdksync - \(FM-8581\) - Debian 10 added to travis and provision file refactored [\#902](https://github.com/puppetlabs/puppetlabs-apt/pull/902) ([david22swan](https://github.com/david22swan))

### Fixed

- MODULES-10548: make files readonly [\#906](https://github.com/puppetlabs/puppetlabs-apt/pull/906) ([anarcat](https://github.com/anarcat))
- MODULES-10543: only consider lsbdistcodename for apt-transport-https [\#905](https://github.com/puppetlabs/puppetlabs-apt/pull/905) ([anarcat](https://github.com/anarcat))
- MODULES-10543: remove sources.list file on purging [\#904](https://github.com/puppetlabs/puppetlabs-apt/pull/904) ([anarcat](https://github.com/anarcat))
- Include apt in apt::backports [\#891](https://github.com/puppetlabs/puppetlabs-apt/pull/891) ([zivis](https://github.com/zivis))

## [v7.3.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.3.0) (2019-12-11)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.2.0...v7.3.0)

### Added

- Adding a new parameter for dist [\#890](https://github.com/puppetlabs/puppetlabs-apt/pull/890) ([luckyraul](https://github.com/luckyraul))

### Fixed

- MODULES-10063, extend apt::key to support deeplinks, this time with f… [\#894](https://github.com/puppetlabs/puppetlabs-apt/pull/894) ([atarax](https://github.com/atarax))
- MODULES-10063, extend apt::key to support deeplinks [\#892](https://github.com/puppetlabs/puppetlabs-apt/pull/892) ([atarax](https://github.com/atarax))

## [v7.2.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.2.0) (2019-10-29)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.1.0...v7.2.0)

### Added

- Add apt::mark defined type [\#879](https://github.com/puppetlabs/puppetlabs-apt/pull/879) ([tuxmea](https://github.com/tuxmea))
- \(FM-8394\) add debian 10 testing [\#876](https://github.com/puppetlabs/puppetlabs-apt/pull/876) ([ThoughtCrhyme](https://github.com/ThoughtCrhyme))
- Add apt::key\_options for default apt::key options [\#873](https://github.com/puppetlabs/puppetlabs-apt/pull/873) ([raphink](https://github.com/raphink))
- implement apt.conf.d purging [\#869](https://github.com/puppetlabs/puppetlabs-apt/pull/869) ([lelutin](https://github.com/lelutin))

### Fixed

- Install gnupg instead of dirmngr [\#866](https://github.com/puppetlabs/puppetlabs-apt/pull/866) ([martijndegouw](https://github.com/martijndegouw))

## [v7.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.1.0) (2019-07-30)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.0.1...v7.1.0)

### Added

- \(FM-8215\) Convert to using litmus [\#864](https://github.com/puppetlabs/puppetlabs-apt/pull/864) ([florindragos](https://github.com/florindragos))

## [v7.0.1](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.0.1) (2019-05-13)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/7.0.0...v7.0.1)

## [7.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/7.0.0) (2019-04-24)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/6.3.0...7.0.0)

### Changed

- pdksync - \(MODULES-8444\) - Raise lower Puppet bound [\#853](https://github.com/puppetlabs/puppetlabs-apt/pull/853) ([david22swan](https://github.com/david22swan))

### Added

- Allow weak SSL verification for apt\_key [\#849](https://github.com/puppetlabs/puppetlabs-apt/pull/849) ([tuxmea](https://github.com/tuxmea))

## [6.3.0](https://github.com/puppetlabs/puppetlabs-apt/tree/6.3.0) (2019-01-21)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/6.2.1...6.3.0)

### Added

- Add support for dist-upgrade & autoremove action [\#832](https://github.com/puppetlabs/puppetlabs-apt/pull/832) ([aboks](https://github.com/aboks))
- \(MODULES-8321\) - Add manage\_auth\_conf parameter [\#831](https://github.com/puppetlabs/puppetlabs-apt/pull/831) ([eimlav](https://github.com/eimlav))

### Fixed

- \(MODULES-8418\) Fix /etc/apt/auth.conf owner changing endlessly [\#836](https://github.com/puppetlabs/puppetlabs-apt/pull/836) ([antaflos](https://github.com/antaflos))
- pdksync - \(FM-7655\) Fix rubygems-update for ruby \< 2.3 [\#835](https://github.com/puppetlabs/puppetlabs-apt/pull/835) ([tphoney](https://github.com/tphoney))
- \(MODULES-8326\) - apt-transport-https not ensured properly [\#830](https://github.com/puppetlabs/puppetlabs-apt/pull/830) ([eimlav](https://github.com/eimlav))

## [6.2.1](https://github.com/puppetlabs/puppetlabs-apt/tree/6.2.1) (2018-11-20)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/6.2.0...6.2.1)

### Fixed

- \(MODULES-8272\) - Revert "Autorequire dirmngr in apt\_key types" [\#825](https://github.com/puppetlabs/puppetlabs-apt/pull/825) ([eimlav](https://github.com/eimlav))

## [6.2.0](https://github.com/puppetlabs/puppetlabs-apt/tree/6.2.0) (2018-11-19)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/6.1.1...6.2.0)

### Added

- \(MODULES-8081\): add support for hkps:// protocol in apt::key [\#815](https://github.com/puppetlabs/puppetlabs-apt/pull/815) ([simondeziel](https://github.com/simondeziel))

### Fixed

- Apt-key fixes to properly work on Debian 9 [\#822](https://github.com/puppetlabs/puppetlabs-apt/pull/822) ([ekohl](https://github.com/ekohl))
- \(maint\) - Update Link to REFERENCE.md [\#811](https://github.com/puppetlabs/puppetlabs-apt/pull/811) ([pmcmaw](https://github.com/pmcmaw))

## [6.1.1](https://github.com/puppetlabs/puppetlabs-apt/tree/6.1.1) (2018-10-01)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/6.1.0...6.1.1)

### Fixed

- Revert "\(MODULES-6408\) - Fix dirmngr install failing" [\#808](https://github.com/puppetlabs/puppetlabs-apt/pull/808) ([eimlav](https://github.com/eimlav))

## [6.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/6.1.0) (2018-09-28)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/6.0.0...6.1.0)

### Added

- pdksync - \(FM-7392\) - Puppet 6 Testing Changes [\#800](https://github.com/puppetlabs/puppetlabs-apt/pull/800) ([pmcmaw](https://github.com/pmcmaw))
- pdksync - \(MODULES-6805\) metadata.json shows support for puppet 6 [\#798](https://github.com/puppetlabs/puppetlabs-apt/pull/798) ([tphoney](https://github.com/tphoney))
- \(MODULES-3307\) - Auto update expired keys [\#795](https://github.com/puppetlabs/puppetlabs-apt/pull/795) ([eimlav](https://github.com/eimlav))
- \(FM-7316\) - Implementation of the i18n process [\#789](https://github.com/puppetlabs/puppetlabs-apt/pull/789) ([david22swan](https://github.com/david22swan))
- Introduce an Apt::Proxy type to validate the hash [\#773](https://github.com/puppetlabs/puppetlabs-apt/pull/773) ([ekohl](https://github.com/ekohl))

### Fixed

- \(MODULES-6408\) - Fix dirmngr install failing [\#801](https://github.com/puppetlabs/puppetlabs-apt/pull/801) ([eimlav](https://github.com/eimlav))
- \(MODULES-1630\) - Expanding source list fix to cover all needed versions [\#788](https://github.com/puppetlabs/puppetlabs-apt/pull/788) ([david22swan](https://github.com/david22swan))

## [6.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/6.0.0) (2018-08-24)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/5.0.1...6.0.0)

### Changed

- \(MODULES-7668\) Remove support for Puppet 4.7 [\#780](https://github.com/puppetlabs/puppetlabs-apt/pull/780) ([jarretlavallee](https://github.com/jarretlavallee))

### Added

- Check existence of gpg key in apt:ppa [\#774](https://github.com/puppetlabs/puppetlabs-apt/pull/774) ([wenzhengjiang](https://github.com/wenzhengjiang))
- Make sure PPA source file is absent when apt-add-repository fails [\#768](https://github.com/puppetlabs/puppetlabs-apt/pull/768) ([wenzhengjiang](https://github.com/wenzhengjiang))

## 5.0.1

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/5.0.0...5.0.1)

### Fixed

- \(MODULES-7540\) - add apt-transport-https with https [\#775](https://github.com/puppetlabs/puppetlabs-apt/pull/775) ([tphoney](https://github.com/tphoney))

## [5.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/5.0.0) (2018-07-18)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.5.1...5.0.0)

### Changed

- \[FM-6956\] Removal of unsupported Debian 7 from apt [\#760](https://github.com/puppetlabs/puppetlabs-apt/pull/760) ([david22swan](https://github.com/david22swan))

### Added

- \(MODULES-7467\) Update apt to support Ubuntu 18.04 [\#769](https://github.com/puppetlabs/puppetlabs-apt/pull/769) ([david22swan](https://github.com/david22swan))
- Support managing login configurations in /etc/apt/auth.conf [\#752](https://github.com/puppetlabs/puppetlabs-apt/pull/752) ([antaflos](https://github.com/antaflos))

### Fixed

- \(MODULES-7327\) - Update README with supported OS [\#767](https://github.com/puppetlabs/puppetlabs-apt/pull/767) ([pmcmaw](https://github.com/pmcmaw))
- \(bugfix\) Dont run ftp tests in travis [\#766](https://github.com/puppetlabs/puppetlabs-apt/pull/766) ([tphoney](https://github.com/tphoney))
- \(maint\) make apt testing more stable, cleanup [\#764](https://github.com/puppetlabs/puppetlabs-apt/pull/764) ([tphoney](https://github.com/tphoney))
- Remove .length from variable $pin\_release in app [\#754](https://github.com/puppetlabs/puppetlabs-apt/pull/754) ([paladox](https://github.com/paladox))
- Replace UTF-8 whitespace in comment [\#748](https://github.com/puppetlabs/puppetlabs-apt/pull/748) ([bernhardschmidt](https://github.com/bernhardschmidt))
- Fix "E: Unable to locate package  -y" [\#747](https://github.com/puppetlabs/puppetlabs-apt/pull/747) ([aboks](https://github.com/aboks))
- Fix automatic coercion warning [\#743](https://github.com/puppetlabs/puppetlabs-apt/pull/743) ([smortex](https://github.com/smortex))

## Supported Release [4.5.1]
### Summary
This release fixes CVE-2018-6508 which is a potential arbitrary code execution via tasks.

### Fixed
- Fix init task for arbitrary remote code

## Supported Release [4.5.0]
### Summary
This release uses the PDK convert functionality which in return makes the module PDK compliant. It also includes a roll up of maintenance changes.

### Added
- PDK convert apt ([MODULES-6452](https://tickets.puppet.com/browse/MODULES-6452)).
- Testing on Travis using rvm 2.4.1.
- Modulesync updates.

### Fixed
- Changes to address additional Rubocop failures.
- (maint) Addressing puppet-lint doc warnings.

### Removed
- `gem update bundler` command in .travis.yml due to ([MODULES-6339](https://tickets.puppet.com/browse/MODULES-6339)).

## Supported Release [4.4.1]
### Summary
This release is to update the formatting of the module, Rubocop having been run for all ruby files and been set to run automatically on all future commits.

### Changed
- Rubocop has been implemented.

## Supported Release [4.4.0]
### Summary

This release is a rollup of new features and fixes.

#### Added
- Install `apt-transport-https` if using Debian 7, 8, 9 or Ubuntu 14.04, 16.04.
- Adds a boolean option `direct` to proxy settings to bypass `https_proxy` if not set.
- Adds facter facts for `dist-upgrade` apt updates.

#### Changed
- Update class is now private.
- Some tidyup of ruby code from Rubocop.
- Fixed circular dependency for package dirmngr.
- Debian updates are no longer treated as security updates.
- Legacy functions have been removed.
- Updates to tests.

#### Fixed
- [(MODULES-4265)](https://tickets.puppetlabs.com/browse/MODULES-4265) Detect security updates from multiple sources.

## Supported Release [4.3.0]
### Summary

This release is adding Tasks to the apt module.

#### Added
- Add a task that allows apt-get update and upgrade

## Supported Release [4.2.0]
### Summary

This release is primarily to fix an error around GPG keys in Debian 9, but includes some other small features and fixes as well.

#### Added
- `apt_package_security_updates` fact
- The ability to modify the loglevel of `Exec['apt_update'}`
- Puppet 5 support

#### Changed
- Ubuntu 16.04 now uses `software-priorities-common`

#### Removed
- Debian 6, Ubuntu 10.04 and 12.04 support. Existing compatibility remains intact but bugs will not be prioritized for these OSes.

#### Fixed
- **[(MODULES-4686)](https://tickets.puppetlabs.com/browse/MODULES-4686) an error that was causing GPG keyserver imports to fail on Debian 9**

## Supported Release 4.1.0
### Summary

This release removes Data in Modules due to current compatibility issues and reinstates the params.pp file. Also includes a couple of bug fixes.

#### Features
- (MODULES-4973) Data in Modules which was introduced in the last release has now been reverted due to compatibility issues.

#### Bugfixes
- Now apt_key only sends the auth basic header when userinfo can be parsed from the URL.
- Reverted the removal of Evolving Web's attribution in NOTICE file.
- Test added to ensure empty string allowed for $release in apt::source.


## Supported Release 3.0.0 and 4.0.0
### Summary

This release adds new Puppet 4 features: data in modules, EPP templates, the $facts hash, and data types. This release is fully backwards compatible to existing Puppet 4 configurations and provides you with deprecation warnings for every argument that will not work as expected with the final 4.0.0 release. See the stdlib docs here for an in-depth discussion of this: https://github.com/puppetlabs/puppetlabs-stdlib#validate_legacy

If you want to learn more about the new features used or you wish to upgrade a module yourself, have a look at the NTP: A Puppet 4 language update blog post.

If you're still running Puppet 3, remain on the latest puppetlabs-apt 2.x release for now, and see the documentation to upgrade to Puppet 4.

#### Changes

Data in modules: Moves all distribution and OS-dependent defaults into YAML files in data/, alleviating the need for a params class. Note that while this feature is currently still classed as experimental, the final implementation will support the changes here.
EPP templating: Uses the Puppet language as a base for templates to create simpler and safer templates. No need for Ruby anymore!
The $facts hash: Makes facts visibly distinct from other variables for more readable and maintainable code. This helps eliminate confusion if you use a local variable whose name happens to match that of a common fact.
Data types for validation: Helps you find and replace deprecated code in existing validate functions with stricter, more readable data type notation. First upgrade to the 3.0.0 release of this module, and address all deprecation warnings before upgrading to the final 4.0.0 release. Please see the stdlib docs for an in-depth discussion of this process.

#### Bugfixes
- Fix apt::source epp template regression introduced in 3.0.0 for the architecture parameter

## Supported Release 2.4.0
### Summary
A release that includes only a couple of additional features, but includes several cleanups and bugfixes around existing issues.

#### Features
- Tests updated to check for idempotency.
- (MODULES-4224) Implementation of beaker-module_install_helper.
- Deprecation warnings are now handled by the deprecation function in stdlib.

#### Bugfixes
- Now http and https sources fixed for apt_key and can take a userinfo.
- GPG key update.
- Notify_update param now defaults to true to avoid validation errors.
- Implement retry on tests which pull key from a key server which sometimes times out (transient error).
- String comparison error now comphensated for in update.pp.
- (MODULES-4104) Removal of the port number from repository location in order to get the host name of the repository.
- Puppet lint warnings addressed.
- A few small readme issues addressed.

## Supported Release 2.3.0
### Summary
A release containing many bugfixes with additional features.

#### Features
- Apt_updates facts now use /usr/bin/apt-get.
- Addition of notify update to apt::source.
- Update to newest modulesync_configs.
- Installs software-properties-common for Xenial.
- Modulesync updates.
- Add ability to specify a hash of apt::conf defines.

#### Bugfixes
- A clean up of spec/defines/key_compat_specs, also now runs under STRICT_VARIABLES.
- Apt::setting expects priority to be an integer, set defaults accordingly.
- Fixed version check for Ubuntu on 16.04.
- Now uses hkps.pool.sks-keyservers.net instead of pgp.mit.edu.
- Updates and fixes to tests. General cleanup.
- Fixed regexp for $ensure params.
- Apt/params: Remove unused LSB facts.
- Replaced `-s` with `-f` in ppa rspec tests - After the repository is added, the "${::apt::sources_list_d}/${sources_list_d_filename}" file is created as an empty file. The unless condition of Exec["add-apt-repository-${name}"] calls test -s, which returns 1 if the file is empty. Because the file is empty, the unless condition is never true and the repository is added on every execution. This change replaces the -s test condition with -f, which is true if the file exists or false otherwise.
- Limit non-strict parsing to pre-3.5.0 only - Puppet 3.5.0 introduced strict variables and the module handles strict variables by using the defined() function. This does not work on prior versions of puppet so we now gate based on that version. Puppet 4 series has a new setting `strict` that may be set to enforce strict variables while `strict_variables` remains unset (see PUP-6358) which causes the conditional in manifests/params.pp to erroniously use non-strict 3.5-era parsing and fail. This new conditional corrects the cases such that strict variable behavior happens on versions 3.5.0 and later.

## Supported Release 2.2.2
### Summary

Several bug fixes and the addition of support updates to Debian 8 and Ubuntu Wily.

#### Bugfixes
- Small fixes to descriptions within the readme and the addition of some examples.
- Updates to run on Ubuntu Wily.
- Fixed apt_key tempfile race condition.
- Run stages limitation added to the documentation.
- Remove unneeded whitespace in source.list template.
- Handle PPA names that contain a plus character.
- Update to current msync configs.
- Avoid duplicate package resources when package_manage => true.
- Avoid multiple package resource declarations.
- Ensure PPAs in tests have valid form.
- Look for correct sources.list.d file for apt::ppa.
- Debian 8 support addiiton to metadata.

## Supported Release 2.2.1
### Summary

Small release for support of newer PE versions. This increments the version of PE in the metadata.json file.

## 2015-09-29 - Supported Release 2.2.0
### Summary

This release includes a few bugfixes.

#### Features
- Adds an `ensure` parameter for user control of proxy presence.
- Adds ability to set `notify_update` to `apt::conf` (MODULES-2269).
- Apt pins no longer trigger an `apt-get update` run.
- Adds support for creating pins from main class.

#### Bugfixes
- Updates to use the official Debian mirrors.
- Fixes path to `preferences` and `preferences.d`
- Fixes pinning for backports (MODULES-2446).
- Fixes the name/extension of the preferences files.

## 2015-07-28 - Supported Release 2.1.1
### Summary

This release includes a few bugfixes.

#### Bugfixes
- Fix incorrect use of anchoring (MODULES-2190)
- Use correct comment type for apt.conf files
- Test fixes
- Documentation fixes

## 2015-06-16 - Supported Release 2.1.0
### Summary

This release largely makes `apt::key` and `apt::source` API-compatible with the 1.8.x versions for ease in upgrading, and also addresses some compatibility issues with older versions of Puppet.

#### Features
- Add API compatibility to `apt::key` and `apt::source`
- Added `apt_reboot_required` fact

#### Bugfixes
- Fix compatibility with Puppet versions 3.0-3.4
- Work around future parser bug PUP-4133

## 2015-04-28 - Supported Release 2.0.1
### Summary

This bug fixes a few compatibility issues that came up with the 2.0.0 release, and includes test and documentation updates.

#### Bugfixes
- Fix incompatibility with keyrings containing multiple keys
- Fix bugs preventing the module from working with Puppet < 3.5.0

## 2015-04-07 - Supported Release 2.0.0
### Summary

This is a major rewrite of the apt module. Many classes and defines were removed, but all existing functionality should still work. Please carefully review documentation before upgrading.

#### Backwards-incompatible changes

As this is a major rewrite of the module there are a great number of backwards incompatible changes. Please review this and the updated README carefully before upgrading.

##### `apt_key`
- `keyserver_options` parameter renamed to `options`

##### `apt::backports`
- This no longer works out of the box on Linux Mint. If using this on mint, you must specify the `location`, `release`, `repos`, and `key` parameters. [Example](examples/backports.pp)

##### `apt::builddep`
- This define was removed. Functionality can be matched passing 'build-dep' to `install_options` in the package resource. [Example](examples/builddep.pp)

##### `apt::debian::testing`
- This class was removed. Manually add an `apt::source` instead. [Example](examples/debian_testing.pp)

##### `apt::debian::unstable`
- This class was removed. Manually add an `apt::source` instead. [Example](examples/debian_unstable.pp)

##### `apt::force`
- This define was removed. Functionallity can be matched by setting `install_options` in the package resource. See [here](examples/force.pp) for how to set the options.

##### `apt::hold`
- This define was removed. Simply use an `apt::pin` with `priority => 1001` for the same functionality.

##### `apt`
- `always_apt_update` - This parameter was removed. Use `update => { 'frequency' => 'always' }` instead.
- `apt_update_frequency` - This parameter was removed. Use `update => { 'frequency' => <frequency> }` instead.
- `disable_keys` - This parameter was removed. See this [example](examples/disable_keys.pp) if you need this functionality.
- `proxy_host` - This parameter was removed. Use `proxy => { 'host' => <host> }` instead.
- `proxy_port` - This parameter was removed. Use `proxy => { 'port' => <port> }` instead.
- `purge_sources_list` - This parameter was removed. Use `purge => { 'sources.list' => <bool> }` instead.
- `purge_sources_list_d` - This parameter was removed. Use `purge => { 'sources.list.d' => <bool> }` instead.
- `purge_preferences` - This parameter was removed. Use `purge => { 'preferences' => <bool> }` instead.
- `purge_preferences_d` - This parameter was removed. Use `purge => { 'preferences.d' => <bool> }` instead.
- `update_timeout` - This parameter was removed. Use `update => { 'timeout' => <timeout> }` instead.
- `update_tries` - This parameter was removed. Use `update => { 'tries' => <tries> }` instead.

##### `apt::key`
- `key` - This parameter was renamed to `id`.
- `key_content` - This parameter was renamed to `content`.
- `key_source` - This parameter was renamed to `source`.
- `key_server` - This parameter was renamed to `server`.
- `key_options` - This parameter was renamed to `options`.

##### `apt::release`
- This class was removed. See this [example](examples/release.pp) for how to achieve this functionality.

##### `apt::source`
- `include_src` - This parameter was removed. Use `include => { 'src' => <bool> }` instead. ***NOTE*** This now defaults to false.
- `include_deb` - This parameter was removed. Use `include => { 'deb' => <bool> }` instead.
- `required_packages` - This parameter was removed. Use package resources for these packages if needed.
- `key` - This can either be a key id or a hash including key options. If using a hash, `key => { 'id' => <id> }` must be specified.
- `key_server` - This parameter was removed. Use `key => { 'server' => <server> }` instead.
- `key_content` - This parameter was removed. Use `key => { 'content' => <content> }` instead.
- `key_source` - This parameter was removed. Use `key => { 'source' => <source> }` instead.
- `trusted_source` - This parameter was renamed to `allow_unsigned`.

##### `apt::unattended_upgrades`
- This class was removed and is being republished under the puppet-community namespace. The git repository is available [here](https://github.com/puppet-community/puppet-unattended_upgrades) and it will be published to the forge [here](https://forge.puppetlabs.com/puppet/unattended_upgrades).

#### Changes to default behavior
- By default purge unmanaged files in 'sources.list', 'sources.list.d', 'preferences', and 'preferences.d'.
- Changed default for `package_manage` in `apt::ppa` to `false`. Set to `true` in a single PPA if you need the package to be managed.
- `apt::source` will no longer include the `src` entries by default.
- `pin` in `apt::source` now defaults to `undef` instead of `false`

#### Features
- Added the ability to pass hashes of `apt::key`s, `apt::ppa`s, and `apt::setting`s to `apt`.
- Added 'https' key to `proxy` hash to allow disabling `https_proxy` for the `apt::ppa` environment.
- Added `apt::setting` define to abstract away configuration.
- Added the ability to pass hashes to `pin` and `key` in `apt::backports` and `apt::source`.

#### Bugfixes
- Fixes for strict variables.

## 2015-03-17 - Supported Release 1.8.0
### Summary

This is the last planned feature release of the 1.x series of this module. All new features will be evaluated for puppetlabs-apt 2.x.

This release includes many important features, including support for full fingerprints, and fixes issues where `apt_key` was not supporting user/password and `apt_has_updates` was not properly parsing the `apt-check` output.

#### Changes to default behavior
- The apt module will now throw warnings if you don't use full fingerprints for `apt_key`s

#### Features
- Use gpg to check keys to work around https://bugs.launchpad.net/ubuntu/+source/gnupg2/+bug/1409117 (MODULES-1675)
- Add 'oldstable' to the default update origins for wheezy
- Add utopic, vivid, and cumulus compatibility
- Add support for full fingerprints
- New parameter for `apt::source`
  - `trusted_source`
- New parameters for `apt::ppa`
  - `package_name`
  - `package_manage`
- New parameter for `apt::unattended_upgrades`
  - `legacy_origin`
- Separate `apt::pin` from `apt::backports` to allow pin by release instead of origin

#### Bugfixes
- Cleanup lint and future parser issues
- Fix to support username and passwords again for `apt_key` (MODULES-1119)
- Fix issue where `apt::force` `$install_check` didn't work with non-English locales (MODULES-1231)
- Allow 5 digit ports in `apt_key`
- Fix for `ensure => absent` in `apt_key` (MODULES-1661)
- Fix `apt_has_updates` not parsing `apt-check` output correctly
- Fix inconsistent headers across files (MODULES-1200)
- Clean up formatting for 50unattended-upgrades.erb

## 2014-10-28 - Supported Release 1.7.0
### Summary

This release includes several new features, documentation and test improvements, and a few bug fixes.

#### Features
- Updated unit and acceptance tests
- Update module to work with Linux Mint
- Documentation updates
- Future parser / strict variables support
- Improved support for long GPG keys
- New parameters!
  - Added `apt_update_frequency` to apt
  - Added `cfg_files` and `cfg_missing` parameters to apt::force
  - Added `randomsleep` to apt::unattended_upgrades
- Added `apt_update_last_success` fact
- Refactored facts for performance improvements

#### Bugfixes
- Update apt::builddep to require Exec['apt_update'] instead of notifying it
- Clean up lint errors

## 2014-08-20 - Supported Release 1.6.0
### Summary

#### Features
- Allow URL or domain name for key_server parameter
- Allow custom comment for sources list
- Enable auto-update for Debian squeeze LTS
- Add facts showing available updates
- Test refactoring

#### Bugfixes
- Allow dashes in URL or domain for key_server parameter

## 2014-08-13 - Supported Release 1.5.3
### Summary

This is a bugfix releases.  It addresses a bad regex, failures with unicode
characters, and issues with the $proxy_host handling in apt::ppa.

#### Features
- Synced files from Modulesync

#### Bugfixes
- Fix regex to follow APT requirements in apt::pin
- Fix for unicode characters
- Fix inconsistent $proxy_host handling in apt and apt::ppa
- Fix typo in README
- Fix broken acceptance tests

## 2014-07-15 - Supported Release 1.5.2
### Summary

This release merely updates metadata.json so the module can be uninstalled and
upgraded via the puppet module command.

## 2014-07-10 - Supported Release 1.5.1
### Summary

This release has added tests to ensure graceful failure on OSX.

## 2014-06-04 - Release 1.5.0
### Summary

This release adds support for Ubuntu 14.04.  It also includes many new features
and important bugfixes.  One huge change is that apt::key was replaced with
apt_key, which allows you to use puppet resource apt_key to inventory keys on
your system.

Special thanks to daenney, our intrepid unofficial apt maintainer!

#### Features
- Add support for Ubuntu Trusty!
- Add apt::hold define
- Generate valid *.pref files in apt::pin
- Made pin_priority configurable for apt::backports
- Add apt_key type and provider
- Rename "${apt_conf_d}/proxy" to "${apt_conf_d}/01proxy"
- apt::key rewritten to use apt_key type
- Add support for update_tries to apt::update

#### Bugfixes
- Typo fixes
- Fix unattended upgrades
- Removed bogus line when using purge_preferences
- Fix apt::force to upgrade allow packages to be upgraded to the pacakge from the specified release

## 2014-03-04 - Supported Release 1.4.2
### Summary

This is a supported release. This release tidies up 1.4.1 and re-enables
support for Ubuntu 10.04

#### Features

#### Bugfixes
- Fix apt:ppa to include the -y Ubuntu 10.04 requires.
- Documentation changes.
- Test fixups.

#### Known Bugs

* No known issues.



## 2014-02-13 1.4.1
### Summary
This is a bugfix release.

#### Bugfixes
- Fix apt::force unable to upgrade packages from releases other than its original
- Removed a few refeneces to aptitude instead of apt-get for portability
- Removed call to getparam() due to stdlib dependency
- Correct apt::source template when architecture is provided
- Retry package installs if apt is locked
- Use root to exec in apt::ppa
- Updated tests and converted acceptance tests to beaker

## 2013-10-08 - Release 1.4.0

### Summary

Minor bugfix and allow the timeout to be adjusted.

#### Features
- Add an `updates_timeout` to apt::params

#### Bugfixes
- Ensure apt::ppa can read a ppa removed by hand.


## 2013-10-08 - Release 1.3.0
### Summary

This major feature in this release is the new apt::unattended_upgrades class,
allowing you to handle Ubuntu's unattended feature.  This allows you to select
specific packages to automatically upgrade without any further user
involvement.

In addition we extend our Wheezy support, add proxy support to apt:ppa and do
various cleanups and tweaks.

#### Features
- Add apt::unattended_upgrades support for Ubuntu.
- Add wheezy backports support.
- Use the geoDNS http.debian.net instead of the main debian ftp server.
- Add `options` parameter to apt::ppa in order to pass options to apt-add-repository command.
- Add proxy support for apt::ppa (uses proxy_host and proxy_port from apt).

#### Bugfixes
- Fix regsubst() calls to quote single letters (for future parser).
- Fix lint warnings and other misc cleanup.


## 2013-07-03 - Release 1.2.0

#### Features
- Add geppetto `.project` natures
- Add GH auto-release
- Add `apt::key::key_options` parameter
- Add complex pin support using distribution properties for `apt::pin` via new properties:
  - `apt::pin::codename`
  - `apt::pin::release_version`
  - `apt::pin::component`
  - `apt::pin::originator`
  - `apt::pin::label`
- Add source architecture support to `apt::source::architecture`

#### Bugfixes
- Use apt-get instead of aptitude in apt::force
- Update default backports location
- Add dependency for required packages before apt-get update


## 2013-06-02 - Release 1.1.1
### Summary

This is a bug fix release that resolves a number of issues:

* By changing template variable usage, we remove the deprecation warnings
  for Puppet 3.2.x
* Fixed proxy file removal, when proxy absent

Some documentation, style and whitespaces changes were also merged. This
release also introduced proper rspec-puppet unit testing on Travis-CI to help
reduce regression.

Thanks to all the community contributors below that made this patch possible.

#### Detail Changes

* fix minor comment type (Chris Rutter)
* whitespace fixes (Michael Moll)
* Update travis config file (William Van Hevelingen)
* Build all branches on travis (William Van Hevelingen)
* Standardize travis.yml on pattern introduced in stdlib (William Van Hevelingen)
* Updated content to conform to README best practices template (Lauren Rother)
* Fix apt::release example in readme (Brian Galey)
* add @ to variables in template (Peter Hoeg)
* Remove deprecation warnings for pin.pref.erb as well (Ken Barber)
* Update travis.yml to latest versions of puppet (Ken Barber)
* Fix proxy file removal (Scott Barber)
* Add spec test for removing proxy configuration (Dean Reilly)
* Fix apt::key listing longer than 8 chars (Benjamin Knofe)




## Release 1.1.0
### Summary

This release includes Ubuntu 12.10 (Quantal) support for PPAs.

---

## 2012-05-25 - Puppet Labs <info@puppetlabs.com> - Release 0.0.4
### Summary

 * Fix ppa list filename when there is a period in the PPA name
 * Add .pref extension to apt preferences files
 * Allow preferences to be purged
 * Extend pin support


## 2012-05-04 - Puppet Labs <info@puppetlabs.com> - Release 0.0.3
### Summary

 * only invoke apt-get update once
 * only install python-software-properties if a ppa is added
 * support 'ensure => absent' for all defined types
 * add apt::conf
 * add apt::backports
 * fixed Modulefile for module tool dependency resolution
 * configure proxy before doing apt-get update
 * use apt-get update instead of aptitude for apt::ppa
 * add support to pin release


## 2012-03-26 - Puppet Labs <info@puppetlabs.com> - Release 0.0.2
### Summary

* 41cedbb (#13261) Add real examples to smoke tests.
* d159a78 (#13261) Add key.pp smoke test
* 7116c7a (#13261) Replace foo source with puppetlabs source
* 1ead0bf Ignore pkg directory.
* 9c13872 (#13289) Fix some more style violations
* 0ea4ffa (#13289) Change test scaffolding to use a module & manifest dir fixture path
* a758247 (#13289) Clean up style violations and fix corresponding tests
* 99c3fd3 (#13289) Add puppet lint tests to Rakefile
* 5148cbf (#13125) Apt keys should be case insensitive
* b9607a4 Convert apt::key to use anchors


## 2012-03-07 - Puppet Labs <info@puppetlabs.com> - Release 0.0.1
### Summary

* d4fec56 Modify apt::source release parameter test
* 1132a07 (#12917) Add contributors to README
* 8cdaf85 (#12823) Add apt::key defined type and modify apt::source to use it
* 7c0d10b (#12809) $release should use $lsbdistcodename and fall back to manual input
* be2cc3e (#12522) Adjust spec test for splitting purge
* 7dc60ae (#12522) Split purge option to spare sources.list
* 9059c4e Fix source specs to test all key permutations
* 8acb202 Add test for python-software-properties package
* a4af11f Check if python-software-properties is defined before attempting to define it.
* 1dcbf3d Add tests for required_packages change
* f3735d2 Allow duplicate $required_packages
* 74c8371 (#12430) Add tests for changes to apt module
* 97ebb2d Test two sources with the same key
* 1160bcd (#12526) Add ability to reverse apt { disable_keys => true }
* 2842d73 Add Modulefile to puppet-apt
* c657742 Allow the use of the same key in multiple sources
* 8c27963 (#12522) Adding purge option to apt class
* 997c9fd (#12529) Add unit test for apt proxy settings
* 50f3cca (#12529) Add parameter to support setting a proxy for apt
* d522877 (#12094) Replace chained .with_* with a hash
* 8cf1bd0 (#12094) Remove deprecated spec.opts file
* 2d688f4 (#12094) Add rspec-puppet tests for apt
* 0fb5f78 (#12094) Replace name with path in file resources
* f759bc0 (#11953) Apt::force passes $version to aptitude
* f71db53 (#11413) Add spec test for apt::force to verify changes to unless
* 2f5d317 (#11413) Update dpkg query used by apt::force
* cf6caa1 (#10451) Add test coverage to apt::ppa
* 0dd697d include_src parameter in example; Whitespace cleanup
* b662eb8 fix typos in "repositories"
* 1be7457 Fix (#10451) - apt::ppa fails to "apt-get update" when new PPA source is added
* 864302a Set the pin priority before adding the source (Fix #10449)
* 1de4e0a Refactored as per mlitteken
* 1af9a13 Added some crazy bash madness to check if the ppa is installed already. Otherwise the manifest tries to add it on every run!
* 52ca73e (#8720) Replace Apt::Ppa with Apt::Builddep
* 5c05fa0 added builddep command.
* a11af50 added the ability to specify the content of a key
* c42db0f Fixes ppa test.
* 77d2b0d reformatted whitespace to match recommended style of 2 space indentation.
* 27ebdfc ignore swap files.
* 377d58a added smoke tests for module.
* 18f614b reformatted apt::ppa according to recommended style.
* d8a1e4e Created a params class to hold global data.
* 636ae85 Added two params for apt class
* 148fc73 Update LICENSE.
* ed2d19e Support ability to add more than one PPA
* 420d537 Add call to apt-update after add-apt-repository in apt::ppa
* 945be77 Add package definition for python-software-properties
* 71fc425 Abs paths for all commands
* 9d51cd1 Adding LICENSE
* 71796e3 Heading fix in README
* 87777d8 Typo in README
* f848bac First commit

[5.0.1]:https://github.com/puppetlabs/puppetlabs-apt/compare/5.0.0...5.0.1
[5.0.0]:https://github.com/puppetlabs/puppetlabs-apt/compare/4.5.1...5.0.0
[4.5.1]:https://github.com/puppetlabs/puppetlabs-apt/compare/4.5.0...4.5.1
[4.5.0]:https://github.com/puppetlabs/puppetlabs-apt/compare/4.4.1...4.5.0
[4.4.1]:https://github.com/puppetlabs/puppetlabs-apt/compare/4.4.0...4.4.1
[4.4.0]:https://github.com/puppetlabs/puppetlabs-apt/compare/4.3.0...4.4.0
[4.3.0]:https://github.com/puppetlabs/puppetlabs-apt/compare/4.2.0...4.3.0
[4.2.0]:https://github.com/puppetlabs/puppetlabs-apt/compare/4.1.0...4.2.0


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*

<!-- markdownlint-disable MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v9.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v9.1.0) - 2023-06-08

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v9.0.2...v9.1.0)

### Added

- Require stdlib 9.0.0 or newer [#1114](https://github.com/puppetlabs/puppetlabs-apt/pull/1114) ([smortex](https://github.com/smortex))
- (CONT-1028) puppetlabs/stdlib: Allow 9.x [#1113](https://github.com/puppetlabs/puppetlabs-apt/pull/1113) ([bastelfreak](https://github.com/bastelfreak))
- (CONT-581)  Adding deferred function support for password field [#1110](https://github.com/puppetlabs/puppetlabs-apt/pull/1110) ([Ramesh7](https://github.com/Ramesh7))

### Changed
- (CONT-773) Add Support for Puppet 8 / Remove Support for Puppet 6 [#1101](https://github.com/puppetlabs/puppetlabs-apt/pull/1101) ([david22swan](https://github.com/david22swan))

### Fixed

- (MODULES-10831) key is expired if all subkeys are expired [#1104](https://github.com/puppetlabs/puppetlabs-apt/pull/1104) ([kenyon](https://github.com/kenyon))

## [v9.0.2](https://github.com/puppetlabs/puppetlabs-apt/tree/v9.0.2) - 2023-03-14

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v9.0.1...v9.0.2)

### Fixed

- Adopt new parameter defaults in template [#1090](https://github.com/puppetlabs/puppetlabs-apt/pull/1090) ([tuxmea](https://github.com/tuxmea))
- (CONT-493) PPA validation adjustment [#1085](https://github.com/puppetlabs/puppetlabs-apt/pull/1085) ([LukasAud](https://github.com/LukasAud))
- fix typo in source.pp [#1082](https://github.com/puppetlabs/puppetlabs-apt/pull/1082) ([bastelfreak](https://github.com/bastelfreak))
- fix: remove `apt::` prefix from fact variables [#1081](https://github.com/puppetlabs/puppetlabs-apt/pull/1081) ([johanfleury](https://github.com/johanfleury))
- Updated mark as title can contain dot (fixes #1074) [#1075](https://github.com/puppetlabs/puppetlabs-apt/pull/1075) ([xepa](https://github.com/xepa))

## [v9.0.1](https://github.com/puppetlabs/puppetlabs-apt/tree/v9.0.1) - 2022-12-21

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v9.0.0...v9.0.1)

### Fixed

- (bugfix) - Declare minimum Puppet version 6.24.0 [#1079](https://github.com/puppetlabs/puppetlabs-apt/pull/1079) ([pmcmaw](https://github.com/pmcmaw))
- Do not remove PPA sources.list.d files if purge is enabled [#1069](https://github.com/puppetlabs/puppetlabs-apt/pull/1069) ([Programie](https://github.com/Programie))
- (CONT-173) - Updating deprecated facter instances [#1068](https://github.com/puppetlabs/puppetlabs-apt/pull/1068) ([jordanbreen28](https://github.com/jordanbreen28))
- pdksync - (CONT-130) Dropping Support for Debian 9 [#1065](https://github.com/puppetlabs/puppetlabs-apt/pull/1065) ([jordanbreen28](https://github.com/jordanbreen28))
- (GH-1057) Regex fix to allow dotted resources [#1058](https://github.com/puppetlabs/puppetlabs-apt/pull/1058) ([LukasAud](https://github.com/LukasAud))
- (GH-1055) Fix hardcoded cache path [#1056](https://github.com/puppetlabs/puppetlabs-apt/pull/1056) ([chelnak](https://github.com/chelnak))
- (GH-cat-9) Update module to match current syntax standard [#1053](https://github.com/puppetlabs/puppetlabs-apt/pull/1053) ([david22swan](https://github.com/david22swan))

## [v9.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v9.0.0) - 2022-08-18

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.5.0...v9.0.0)

### Added

- Deal with net-ftp being unavailable [#1050](https://github.com/puppetlabs/puppetlabs-apt/pull/1050) ([ekohl](https://github.com/ekohl))
- pdksync - (GH-cat-11) Certify Support for Ubuntu 22.04 [#1046](https://github.com/puppetlabs/puppetlabs-apt/pull/1046) ([david22swan](https://github.com/david22swan))

### Changed
- Harden PPA defined type [#1052](https://github.com/puppetlabs/puppetlabs-apt/pull/1052) ([chelnak](https://github.com/chelnak))

### Fixed

- Harden apt-mark defined type [#1051](https://github.com/puppetlabs/puppetlabs-apt/pull/1051) ([chelnak](https://github.com/chelnak))

## [v8.5.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.5.0) - 2022-08-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.4.1...v8.5.0)

### Added

- (GH-1038) add support for `check-valid-until` configuration [#1042](https://github.com/puppetlabs/puppetlabs-apt/pull/1042) ([david22swan](https://github.com/david22swan))

## [v8.4.1](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.4.1) - 2022-06-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.4.0...v8.4.1)

### Fixed

- (ISSUE-1036) Conditional `gnupg` include added to init.pp [#1039](https://github.com/puppetlabs/puppetlabs-apt/pull/1039) ([david22swan](https://github.com/david22swan))

## [v8.4.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.4.0) - 2022-06-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.3.0...v8.4.0)

### Changed
- (GH-iac-334) Remove code specific to unsupported OSs [#1024](https://github.com/puppetlabs/puppetlabs-apt/pull/1024) ([david22swan](https://github.com/david22swan))

### Fixed

- pdksync - (GH-iac-334) Remove Support for Ubuntu 14.04 [#1023](https://github.com/puppetlabs/puppetlabs-apt/pull/1023) ([david22swan](https://github.com/david22swan))
- pdksync - (GH-iac-334) Remove Support for Ubuntu 16.04 [#1022](https://github.com/puppetlabs/puppetlabs-apt/pull/1022) ([david22swan](https://github.com/david22swan))
- (MODULES-11301) Don't install gnupg if not needed [#1020](https://github.com/puppetlabs/puppetlabs-apt/pull/1020) ([simondeziel](https://github.com/simondeziel))
- Use fact() function for all os.distro.* facts [#1017](https://github.com/puppetlabs/puppetlabs-apt/pull/1017) ([root-expert](https://github.com/root-expert))
- (maint) Fix resource ordering when apt-transport-https is needed [#1015](https://github.com/puppetlabs/puppetlabs-apt/pull/1015) ([smortex](https://github.com/smortex))
- Omit empty options in source.list template to fix MODULES-11174 [#1013](https://github.com/puppetlabs/puppetlabs-apt/pull/1013) ([mpdude](https://github.com/mpdude))
- Replace `arm64` for `aarch64` in `::apt::source` [#1012](https://github.com/puppetlabs/puppetlabs-apt/pull/1012) ([mpdude](https://github.com/mpdude))
- Fixed gpg file for Ubuntu versions 21.04 and later. [#1011](https://github.com/puppetlabs/puppetlabs-apt/pull/1011) ([Conzar](https://github.com/Conzar))
- (MODULES-10763) Remove frequency collector [#1010](https://github.com/puppetlabs/puppetlabs-apt/pull/1010) ([LTangaF](https://github.com/LTangaF))

## [v8.3.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.3.0) - 2021-10-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.2.0...v8.3.0)

### Fixed

- pdksync - (IAC-1598) - Remove Support for Debian 8 [#1008](https://github.com/puppetlabs/puppetlabs-apt/pull/1008) ([david22swan](https://github.com/david22swan))

## [v8.2.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.2.0) - 2021-08-25

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.1.0...v8.2.0)

### Added

- (maint) Add support for Debian 11 [#1001](https://github.com/puppetlabs/puppetlabs-apt/pull/1001) ([smortex](https://github.com/smortex))

### Fixed

- (main) Allow stdlib 8.0.0 [#1000](https://github.com/puppetlabs/puppetlabs-apt/pull/1000) ([smortex](https://github.com/smortex))

## [v8.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.1.0) - 2021-07-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.0.2...v8.1.0)

### Added

- [MODULES-9695] - Add support for signed-by in source entries [#991](https://github.com/puppetlabs/puppetlabs-apt/pull/991) ([johanfleury](https://github.com/johanfleury))

### Fixed

- apt::source: pass the weak_ssl param to apt::key [#993](https://github.com/puppetlabs/puppetlabs-apt/pull/993) ([kenyon](https://github.com/kenyon))
- (IAC-1597) Increasing MAX_RETRY_COUNT [#987](https://github.com/puppetlabs/puppetlabs-apt/pull/987) ([pmcmaw](https://github.com/pmcmaw))

## [v8.0.2](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.0.2) - 2021-03-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.0.1...v8.0.2)

### Fixed

- (MODULES-10971) - Ensure `apt::keyserver` is considered when creating a default apt:source [#981](https://github.com/puppetlabs/puppetlabs-apt/pull/981) ([david22swan](https://github.com/david22swan))
- (IAC-1497) - Removal of unsupported `translate` dependency [#979](https://github.com/puppetlabs/puppetlabs-apt/pull/979) ([david22swan](https://github.com/david22swan))

## [v8.0.1](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.0.1) - 2021-03-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v8.0.0...v8.0.1)

### Fixed

- MODULES-10956 remove redundant code in provider apt_key [#973](https://github.com/puppetlabs/puppetlabs-apt/pull/973) ([moritz-makandra](https://github.com/moritz-makandra))

## [v8.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v8.0.0) - 2021-03-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.7.1...v8.0.0)

### Changed
- pdksync - Remove Puppet 5 from testing and bump minimal version to 6.0.0 [#969](https://github.com/puppetlabs/puppetlabs-apt/pull/969) ([carabasdaniel](https://github.com/carabasdaniel))

## [v7.7.1](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.7.1) - 2021-02-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.7.0...v7.7.1)

### Fixed

- Use modern os facts [#964](https://github.com/puppetlabs/puppetlabs-apt/pull/964) ([kenyon](https://github.com/kenyon))

## [v7.7.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.7.0) - 2020-12-08

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.6.0...v7.7.0)

### Added

- pdksync - (feat) - Add support for Puppet 7 [#958](https://github.com/puppetlabs/puppetlabs-apt/pull/958) ([daianamezdrea](https://github.com/daianamezdrea))
- Make auth.conf contents Sensitive [#953](https://github.com/puppetlabs/puppetlabs-apt/pull/953) ([suchpuppet](https://github.com/suchpuppet))

## [v7.6.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.6.0) - 2020-09-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.5.0...v7.6.0)

### Added

- (MODULES-10804) option to force purge source.lists file [#948](https://github.com/puppetlabs/puppetlabs-apt/pull/948) ([sheenaajay](https://github.com/sheenaajay))

### Fixed

- (IAC-978) - Removal of inappropriate terminology [#947](https://github.com/puppetlabs/puppetlabs-apt/pull/947) ([david22swan](https://github.com/david22swan))

## [v7.5.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.5.0) - 2020-08-13

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.4.2...v7.5.0)

### Added

- pdksync - (IAC-973) - Update travis/appveyor to run on new default branch main [#940](https://github.com/puppetlabs/puppetlabs-apt/pull/940) ([david22swan](https://github.com/david22swan))
- patch-acng-ssl-support [#938](https://github.com/puppetlabs/puppetlabs-apt/pull/938) ([mdklapwijk](https://github.com/mdklapwijk))
- (IAC-746) - Add ubuntu 20.04 support [#936](https://github.com/puppetlabs/puppetlabs-apt/pull/936) ([david22swan](https://github.com/david22swan))

### Fixed

- (MODULES-10763) loglevel won't affect reports [#942](https://github.com/puppetlabs/puppetlabs-apt/pull/942) ([gguillotte](https://github.com/gguillotte))

## [v7.4.2](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.4.2) - 2020-05-14

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.4.1...v7.4.2)

### Fixed

- fix apt-mark syntax [#927](https://github.com/puppetlabs/puppetlabs-apt/pull/927) ([tryfunc](https://github.com/tryfunc))

## [v7.4.1](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.4.1) - 2020-03-23

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.4.0...v7.4.1)

### Fixed

- Do not specify file modes unless relevant [#923](https://github.com/puppetlabs/puppetlabs-apt/pull/923) ([anarcat](https://github.com/anarcat))
- (MODULES-10583) Revert "MODULES-10548: make files readonly" [#920](https://github.com/puppetlabs/puppetlabs-apt/pull/920) ([carabasdaniel](https://github.com/carabasdaniel))

## [v7.4.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.4.0) - 2020-03-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.3.0...v7.4.0)

### Added

- Add 'include' param to apt::backports [#910](https://github.com/puppetlabs/puppetlabs-apt/pull/910) ([paladox](https://github.com/paladox))
- pdksync - (FM-8581) - Debian 10 added to travis and provision file refactored [#902](https://github.com/puppetlabs/puppetlabs-apt/pull/902) ([david22swan](https://github.com/david22swan))

### Fixed

- MODULES-10548: make files readonly [#906](https://github.com/puppetlabs/puppetlabs-apt/pull/906) ([anarcat](https://github.com/anarcat))
- MODULES-10543: only consider lsbdistcodename for apt-transport-https [#905](https://github.com/puppetlabs/puppetlabs-apt/pull/905) ([anarcat](https://github.com/anarcat))
- MODULES-10543: remove sources.list file on purging [#904](https://github.com/puppetlabs/puppetlabs-apt/pull/904) ([anarcat](https://github.com/anarcat))
- Include apt in apt::backports [#891](https://github.com/puppetlabs/puppetlabs-apt/pull/891) ([zivis](https://github.com/zivis))

## [v7.3.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.3.0) - 2019-12-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.2.0...v7.3.0)

### Added

- Adding a new parameter for dist [#890](https://github.com/puppetlabs/puppetlabs-apt/pull/890) ([luckyraul](https://github.com/luckyraul))

### Fixed

- MODULES-10063, extend apt::key to support deeplinks, this time with f… [#894](https://github.com/puppetlabs/puppetlabs-apt/pull/894) ([atarax](https://github.com/atarax))
- MODULES-10063, extend apt::key to support deeplinks [#892](https://github.com/puppetlabs/puppetlabs-apt/pull/892) ([atarax](https://github.com/atarax))

## [v7.2.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.2.0) - 2019-10-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.1.0...v7.2.0)

### Added

- Add apt::mark defined type [#879](https://github.com/puppetlabs/puppetlabs-apt/pull/879) ([tuxmea](https://github.com/tuxmea))
- (FM-8394) add debian 10 testing [#876](https://github.com/puppetlabs/puppetlabs-apt/pull/876) ([ThoughtCrhyme](https://github.com/ThoughtCrhyme))
- implement apt.conf.d purging [#869](https://github.com/puppetlabs/puppetlabs-apt/pull/869) ([lelutin](https://github.com/lelutin))

### Fixed

- Install gnupg instead of dirmngr [#866](https://github.com/puppetlabs/puppetlabs-apt/pull/866) ([martijndegouw](https://github.com/martijndegouw))

## [v7.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.1.0) - 2019-07-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v7.0.1...v7.1.0)

### Added

- (FM-8215) Convert to using litmus [#864](https://github.com/puppetlabs/puppetlabs-apt/pull/864) ([florindragos](https://github.com/florindragos))

## [v7.0.1](https://github.com/puppetlabs/puppetlabs-apt/tree/v7.0.1) - 2019-05-14

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/7.0.0...v7.0.1)

## [7.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/7.0.0) - 2019-04-24

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/6.3.0...7.0.0)

### Added

- Allow weak SSL verification for apt_key [#849](https://github.com/puppetlabs/puppetlabs-apt/pull/849) ([tuxmea](https://github.com/tuxmea))

### Changed
- pdksync - (MODULES-8444) - Raise lower Puppet bound [#853](https://github.com/puppetlabs/puppetlabs-apt/pull/853) ([david22swan](https://github.com/david22swan))

## [6.3.0](https://github.com/puppetlabs/puppetlabs-apt/tree/6.3.0) - 2019-01-22

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/6.2.1...6.3.0)

### Added

- (MODULES-8321) - Add manage_auth_conf parameter [#831](https://github.com/puppetlabs/puppetlabs-apt/pull/831) ([eimlav](https://github.com/eimlav))

### Fixed

- (MODULES-8418) Fix /etc/apt/auth.conf owner changing endlessly [#836](https://github.com/puppetlabs/puppetlabs-apt/pull/836) ([antaflos](https://github.com/antaflos))
- pdksync - (FM-7655) Fix rubygems-update for ruby < 2.3 [#835](https://github.com/puppetlabs/puppetlabs-apt/pull/835) ([tphoney](https://github.com/tphoney))
- (MODULES-8326) - apt-transport-https not ensured properly [#830](https://github.com/puppetlabs/puppetlabs-apt/pull/830) ([eimlav](https://github.com/eimlav))

## [6.2.1](https://github.com/puppetlabs/puppetlabs-apt/tree/6.2.1) - 2018-11-21

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/6.2.0...6.2.1)

### Fixed

- (MODULES-8272) - Revert "Autorequire dirmngr in apt_key types" [#825](https://github.com/puppetlabs/puppetlabs-apt/pull/825) ([eimlav](https://github.com/eimlav))

## [6.2.0](https://github.com/puppetlabs/puppetlabs-apt/tree/6.2.0) - 2018-11-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/6.1.1...6.2.0)

### Added

- (MODULES-8081): add support for hkps:// protocol in apt::key [#815](https://github.com/puppetlabs/puppetlabs-apt/pull/815) ([simondeziel](https://github.com/simondeziel))

### Fixed

- Apt-key fixes to properly work on Debian 9 [#822](https://github.com/puppetlabs/puppetlabs-apt/pull/822) ([ekohl](https://github.com/ekohl))
- (maint) - Update Link to REFERENCE.md [#811](https://github.com/puppetlabs/puppetlabs-apt/pull/811) ([pmcmaw](https://github.com/pmcmaw))

## [6.1.1](https://github.com/puppetlabs/puppetlabs-apt/tree/6.1.1) - 2018-10-02

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/6.1.0...6.1.1)

### Fixed

- Revert "(MODULES-6408) - Fix dirmngr install failing" [#808](https://github.com/puppetlabs/puppetlabs-apt/pull/808) ([eimlav](https://github.com/eimlav))

## [6.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/6.1.0) - 2018-10-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/6.0.0...6.1.0)

### Added

- pdksync - (FM-7392) - Puppet 6 Testing Changes [#800](https://github.com/puppetlabs/puppetlabs-apt/pull/800) ([pmcmaw](https://github.com/pmcmaw))
- pdksync - (MODULES-6805) metadata.json shows support for puppet 6 [#798](https://github.com/puppetlabs/puppetlabs-apt/pull/798) ([tphoney](https://github.com/tphoney))
- (MODULES-3307) - Auto update expired keys [#795](https://github.com/puppetlabs/puppetlabs-apt/pull/795) ([eimlav](https://github.com/eimlav))
- (FM-7316) - Implementation of the i18n process [#789](https://github.com/puppetlabs/puppetlabs-apt/pull/789) ([david22swan](https://github.com/david22swan))
- Introduce an Apt::Proxy type to validate the hash [#773](https://github.com/puppetlabs/puppetlabs-apt/pull/773) ([ekohl](https://github.com/ekohl))

### Fixed

- (MODULES-6408) - Fix dirmngr install failing [#801](https://github.com/puppetlabs/puppetlabs-apt/pull/801) ([eimlav](https://github.com/eimlav))
- (MODULES-1630) - Expanding source list fix to cover all needed versions [#788](https://github.com/puppetlabs/puppetlabs-apt/pull/788) ([david22swan](https://github.com/david22swan))

## [6.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/6.0.0) - 2018-08-24

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/5.0.1...6.0.0)

### Added

- Check existence of gpg key in apt:ppa [#774](https://github.com/puppetlabs/puppetlabs-apt/pull/774) ([wenzhengjiang](https://github.com/wenzhengjiang))
- Make sure PPA source file is absent when apt-add-repository fails [#768](https://github.com/puppetlabs/puppetlabs-apt/pull/768) ([wenzhengjiang](https://github.com/wenzhengjiang))

### Changed
- (MODULES-7668) Remove support for Puppet 4.7 [#780](https://github.com/puppetlabs/puppetlabs-apt/pull/780) ([jarretlavallee](https://github.com/jarretlavallee))

## [5.0.1](https://github.com/puppetlabs/puppetlabs-apt/tree/5.0.1) - 2018-07-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/5.0.0...5.0.1)

### Fixed

- (MODULES-7540) add apt-transport-https with https [#775](https://github.com/puppetlabs/puppetlabs-apt/pull/775) ([tphoney](https://github.com/tphoney))

## [5.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/5.0.0) - 2018-07-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.5.1...5.0.0)

### Added

- (MODULES-7468) Update apt to support Ubuntu 18.04 [#769](https://github.com/puppetlabs/puppetlabs-apt/pull/769) ([david22swan](https://github.com/david22swan))
- Support managing login configurations in /etc/apt/auth.conf [#752](https://github.com/puppetlabs/puppetlabs-apt/pull/752) ([antaflos](https://github.com/antaflos))

### Changed
- [FM-6956] Removal of unsupported Debian 7 from apt [#760](https://github.com/puppetlabs/puppetlabs-apt/pull/760) ([david22swan](https://github.com/david22swan))

### Fixed

- (MODULES-7327) - Update README with supported OS [#767](https://github.com/puppetlabs/puppetlabs-apt/pull/767) ([pmcmaw](https://github.com/pmcmaw))
- (bugfix) Dont run ftp tests in travis [#766](https://github.com/puppetlabs/puppetlabs-apt/pull/766) ([tphoney](https://github.com/tphoney))
- (maint) make apt testing more stable, cleanup [#764](https://github.com/puppetlabs/puppetlabs-apt/pull/764) ([tphoney](https://github.com/tphoney))
- Remove .length from variable $pin_release in app [#754](https://github.com/puppetlabs/puppetlabs-apt/pull/754) ([paladox](https://github.com/paladox))
- Replace UTF-8 whitespace in comment [#748](https://github.com/puppetlabs/puppetlabs-apt/pull/748) ([bernhardschmidt](https://github.com/bernhardschmidt))
- Fix "E: Unable to locate package  -y" [#747](https://github.com/puppetlabs/puppetlabs-apt/pull/747) ([aboks](https://github.com/aboks))
- Fix automatic coercion warning [#743](https://github.com/puppetlabs/puppetlabs-apt/pull/743) ([smortex](https://github.com/smortex))

## [4.5.1](https://github.com/puppetlabs/puppetlabs-apt/tree/4.5.1) - 2018-02-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.5.0...4.5.1)

## [4.5.0](https://github.com/puppetlabs/puppetlabs-apt/tree/4.5.0) - 2018-01-22

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.4.1...4.5.0)

### Fixed

- MODULES-6235 - Addressing Rubocop Errors [#735](https://github.com/puppetlabs/puppetlabs-apt/pull/735) ([pmcmaw](https://github.com/pmcmaw))

## [4.4.1](https://github.com/puppetlabs/puppetlabs-apt/tree/4.4.1) - 2017-11-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.4.0...4.4.1)

### Added

- Rubocopification [#731](https://github.com/puppetlabs/puppetlabs-apt/pull/731) ([willmeek](https://github.com/willmeek))

## [4.4.0](https://github.com/puppetlabs/puppetlabs-apt/tree/4.4.0) - 2017-11-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.3.0...4.4.0)

### Added

- Add a check for Puppet version to task helper [#722](https://github.com/puppetlabs/puppetlabs-apt/pull/722) ([willmeek](https://github.com/willmeek))
- Add a facter fact for dist-upgrade [#719](https://github.com/puppetlabs/puppetlabs-apt/pull/719) ([willmeek](https://github.com/willmeek))

### Fixed

- Install apt-transport-https if needed [#720](https://github.com/puppetlabs/puppetlabs-apt/pull/720) ([btravouillon](https://github.com/btravouillon))
- Remove tasks acceptance test for non-Debian builds [#717](https://github.com/puppetlabs/puppetlabs-apt/pull/717) ([willmeek](https://github.com/willmeek))
- Do not treat debian stable-updates as security updates [#716](https://github.com/puppetlabs/puppetlabs-apt/pull/716) ([kbarmen](https://github.com/kbarmen))
- Install apt-transport-https in Debian 8 if needed [#714](https://github.com/puppetlabs/puppetlabs-apt/pull/714) ([btravouillon](https://github.com/btravouillon))
- remove legacy functions [#711](https://github.com/puppetlabs/puppetlabs-apt/pull/711) ([b4ldr](https://github.com/b4ldr))

## [4.3.0](https://github.com/puppetlabs/puppetlabs-apt/tree/4.3.0) - 2017-10-11

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.2.0...4.3.0)

## [4.2.0](https://github.com/puppetlabs/puppetlabs-apt/tree/4.2.0) - 2017-09-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.1.0...4.2.0)

### Added

- apt_package_security_updates fact and test [#703](https://github.com/puppetlabs/puppetlabs-apt/pull/703) ([tphoney](https://github.com/tphoney))
- Allow user to modify loglevel of apt-get update Exec resource [#690](https://github.com/puppetlabs/puppetlabs-apt/pull/690) ([tpdownes](https://github.com/tpdownes))

### Fixed

- Switch to deb.debian.org and remove Debian 6.0 [#702](https://github.com/puppetlabs/puppetlabs-apt/pull/702) ([tphoney](https://github.com/tphoney))
- MODULES-4686: gpg keyserver import fails in Debian 9 (Stretch) [#698](https://github.com/puppetlabs/puppetlabs-apt/pull/698) ([deric](https://github.com/deric))
- Ignore subkeys in apt-key's output [#665](https://github.com/puppetlabs/puppetlabs-apt/pull/665) ([tiger-jmw](https://github.com/tiger-jmw))
- (MODULES-4118) Set dpkg option NoLocking in apt_updates fact [#640](https://github.com/puppetlabs/puppetlabs-apt/pull/640) ([jocado](https://github.com/jocado))

## [4.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/4.1.0) - 2017-06-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.0.0...4.1.0)

### Added

- Ensure release allows empty strings [#681](https://github.com/puppetlabs/puppetlabs-apt/pull/681) ([HelenCampbell](https://github.com/HelenCampbell))
- (MODULES-4973) rip out data in modules [#680](https://github.com/puppetlabs/puppetlabs-apt/pull/680) ([eputnam](https://github.com/eputnam))

### Fixed

- Revert removal of Evolving Web's attribution in NOTICE file [#678](https://github.com/puppetlabs/puppetlabs-apt/pull/678) ([DavidS](https://github.com/DavidS))

## [4.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/4.0.0) - 2017-04-27

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/3.0.0...4.0.0)

### Fixed

- Rebase of #668 [#673](https://github.com/puppetlabs/puppetlabs-apt/pull/673) ([hunner](https://github.com/hunner))
- Fix architecture fact overriding unset `architecture` source option [#672](https://github.com/puppetlabs/puppetlabs-apt/pull/672) ([domcleal](https://github.com/domcleal))

## [3.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/3.0.0) - 2017-04-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.4.0...3.0.0)

### Added

- (PUP-6856) Always define facts [#670](https://github.com/puppetlabs/puppetlabs-apt/pull/670) ([hunner](https://github.com/hunner))

## [2.4.0](https://github.com/puppetlabs/puppetlabs-apt/tree/2.4.0) - 2017-04-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.3.0...2.4.0)

### Added

- [MODULES-3562] Implement retry for tests which require modules to pull key from keyserver [#631](https://github.com/puppetlabs/puppetlabs-apt/pull/631) ([wilson208](https://github.com/wilson208))

### Fixed

- [MODULES-4528] Replace Puppet.version.to_f with Puppet::Util::Package.versioncmp [#658](https://github.com/puppetlabs/puppetlabs-apt/pull/658) ([wilson208](https://github.com/wilson208))
- Avoid string comparison error [#635](https://github.com/puppetlabs/puppetlabs-apt/pull/635) ([lkoranda](https://github.com/lkoranda))
- Undef default for $notify_update in source.pp results in problem with Puppet 3.7.2 [#628](https://github.com/puppetlabs/puppetlabs-apt/pull/628) ([cpavanrun](https://github.com/cpavanrun))

## [2.3.0](https://github.com/puppetlabs/puppetlabs-apt/tree/2.3.0) - 2016-09-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.2.2...2.3.0)

### Added

- Add ability to specify a hash of apt::conf defines [#616](https://github.com/puppetlabs/puppetlabs-apt/pull/616) ([ghoneycutt](https://github.com/ghoneycutt))
- Expose notify_update to apt::source [#596](https://github.com/puppetlabs/puppetlabs-apt/pull/596) ([danielhoherd](https://github.com/danielhoherd))

### Fixed

- Fix syntax error [#619](https://github.com/puppetlabs/puppetlabs-apt/pull/619) ([DavidS](https://github.com/DavidS))
- Fixed "unless" test condition for ppa repository [#613](https://github.com/puppetlabs/puppetlabs-apt/pull/613) ([nicobn](https://github.com/nicobn))
- Fix regexp for $ensure params [#609](https://github.com/puppetlabs/puppetlabs-apt/pull/609) ([hfm](https://github.com/hfm))
- Use hkps.pool.sks-keyservers.net instead of pgp.mit.edu [#606](https://github.com/puppetlabs/puppetlabs-apt/pull/606) ([DavidS](https://github.com/DavidS))
- Install software-properties-common for xenial [#605](https://github.com/puppetlabs/puppetlabs-apt/pull/605) ([imphil](https://github.com/imphil))
- Fix version check on 16.04. [#604](https://github.com/puppetlabs/puppetlabs-apt/pull/604) ([tdb](https://github.com/tdb))
- apt::setting expects priority to be an integer, set defaults accordingly [#602](https://github.com/puppetlabs/puppetlabs-apt/pull/602) ([madddi](https://github.com/madddi))
- Fix STRICT_VARIABLE testing [#599](https://github.com/puppetlabs/puppetlabs-apt/pull/599) ([DavidS](https://github.com/DavidS))
- Make apt_updates facts use /usr/bin/apt-get. [#581](https://github.com/puppetlabs/puppetlabs-apt/pull/581) ([robinelfrink](https://github.com/robinelfrink))

## [2.2.2](https://github.com/puppetlabs/puppetlabs-apt/tree/2.2.2) - 2016-02-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.2.1...2.2.2)

### Added

- Add ubuntu 15.10 support [#578](https://github.com/puppetlabs/puppetlabs-apt/pull/578) ([pherjung](https://github.com/pherjung))

### Fixed

- MODULES-2873 - Avoid multiple package resource declarations [#588](https://github.com/puppetlabs/puppetlabs-apt/pull/588) ([werekraken](https://github.com/werekraken))
- Handle PPA names that contain a plus character. [#583](https://github.com/puppetlabs/puppetlabs-apt/pull/583) ([tdb](https://github.com/tdb))
- Look for correct sources.list.d file for apt::ppa [#582](https://github.com/puppetlabs/puppetlabs-apt/pull/582) ([imphil](https://github.com/imphil))
- Fix apt_key tempfile race condition [#572](https://github.com/puppetlabs/puppetlabs-apt/pull/572) ([claytono](https://github.com/claytono))

## [2.2.1](https://github.com/puppetlabs/puppetlabs-apt/tree/2.2.1) - 2015-12-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.2.0...2.2.1)

## [2.2.0](https://github.com/puppetlabs/puppetlabs-apt/tree/2.2.0) - 2015-09-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.1.1...2.2.0)

### Added

- Add support for creating pins from main class [#564](https://github.com/puppetlabs/puppetlabs-apt/pull/564) ([rfdrake](https://github.com/rfdrake))
- Proxy ensure parameter. [#556](https://github.com/puppetlabs/puppetlabs-apt/pull/556) ([mike-callahan](https://github.com/mike-callahan))
- Expose notify_update to apt::conf [#551](https://github.com/puppetlabs/puppetlabs-apt/pull/551) ([bdellegrazie](https://github.com/bdellegrazie))

### Fixed

- Corrected regression with preference files name [#562](https://github.com/puppetlabs/puppetlabs-apt/pull/562) ([Vincent--](https://github.com/Vincent--))
- MODULES-2446 - Fix pinning for backports [#560](https://github.com/puppetlabs/puppetlabs-apt/pull/560) ([underscorgan](https://github.com/underscorgan))
- Fix path to 'preferences' and 'preferences.d'. [#557](https://github.com/puppetlabs/puppetlabs-apt/pull/557) ([fbarbeira](https://github.com/fbarbeira))

## [2.1.1](https://github.com/puppetlabs/puppetlabs-apt/tree/2.1.1) - 2015-07-27

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.1.0...2.1.1)

### Added

- Added additional header template for apt.conf style comments [#540](https://github.com/puppetlabs/puppetlabs-apt/pull/540) ([szynaka](https://github.com/szynaka))

### Fixed

- Fix anchor issues [#547](https://github.com/puppetlabs/puppetlabs-apt/pull/547) ([underscorgan](https://github.com/underscorgan))
- Iterate through multiple keys [#546](https://github.com/puppetlabs/puppetlabs-apt/pull/546) ([igalic](https://github.com/igalic))
- Use Debian's new official mirrors redirector [#545](https://github.com/puppetlabs/puppetlabs-apt/pull/545) ([raoulbhatia](https://github.com/raoulbhatia))
- Revert "Fix use of $::apt::params::backports and $::apt::params::xfac… [#543](https://github.com/puppetlabs/puppetlabs-apt/pull/543) ([underscorgan](https://github.com/underscorgan))
- Fix use of $::apt::params::backports and $::apt::params::xfacts. [#542](https://github.com/puppetlabs/puppetlabs-apt/pull/542) ([Farzy](https://github.com/Farzy))
- Don't add puppetlabs sources for lucid [#537](https://github.com/puppetlabs/puppetlabs-apt/pull/537) ([underscorgan](https://github.com/underscorgan))

## [2.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/2.1.0) - 2015-06-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.0.1...2.1.0)

### Added

- Added new apt_reboot_required fact, updated readme, and added unit tests [#516](https://github.com/puppetlabs/puppetlabs-apt/pull/516) ([dlactin](https://github.com/dlactin))

### Fixed

- Make apt::key compatible with 1.8.x [#527](https://github.com/puppetlabs/puppetlabs-apt/pull/527) ([underscorgan](https://github.com/underscorgan))
- Backwards compatibility with older versions of puppet [#525](https://github.com/puppetlabs/puppetlabs-apt/pull/525) ([ianmacl](https://github.com/ianmacl))
- Only use the strict variables workaround if using strict variables [#524](https://github.com/puppetlabs/puppetlabs-apt/pull/524) ([underscorgan](https://github.com/underscorgan))
- Don't stub puppetversion [#521](https://github.com/puppetlabs/puppetlabs-apt/pull/521) ([hunner](https://github.com/hunner))

## [2.0.1](https://github.com/puppetlabs/puppetlabs-apt/tree/2.0.1) - 2015-04-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.0.0...2.0.1)

### Added

- MODULES-1934: Iterate through multiple keys [#501](https://github.com/puppetlabs/puppetlabs-apt/pull/501) ([underscorgan](https://github.com/underscorgan))

### Fixed

- Restore Puppet 3.4 and earlier compatibility [#511](https://github.com/puppetlabs/puppetlabs-apt/pull/511) ([underscorgan](https://github.com/underscorgan))
- Update tests to work with rspec-puppet 2.x [#504](https://github.com/puppetlabs/puppetlabs-apt/pull/504) ([underscorgan](https://github.com/underscorgan))

## [2.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/2.0.0) - 2015-04-14

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.8.0...2.0.0)

### Added

- Add missing examples for 'removed' functionality [#483](https://github.com/puppetlabs/puppetlabs-apt/pull/483) ([underscorgan](https://github.com/underscorgan))

### Fixed

- Don't purge by default. That seems unnecessarily destructive. [#497](https://github.com/puppetlabs/puppetlabs-apt/pull/497) ([underscorgan](https://github.com/underscorgan))
- apt::conf: Don't require content `ensure=>absent`. [#496](https://github.com/puppetlabs/puppetlabs-apt/pull/496) ([daenney](https://github.com/daenney))
- Remove default support for Linux Mint and Cumulus Networks [#493](https://github.com/puppetlabs/puppetlabs-apt/pull/493) ([underscorgan](https://github.com/underscorgan))
- (MODULES-1156, MODULES-769) Update anchors [#479](https://github.com/puppetlabs/puppetlabs-apt/pull/479) ([underscorgan](https://github.com/underscorgan))
- Remove `update['always'] = true` support [#473](https://github.com/puppetlabs/puppetlabs-apt/pull/473) ([underscorgan](https://github.com/underscorgan))
- Acceptance test fixes [#472](https://github.com/puppetlabs/puppetlabs-apt/pull/472) ([underscorgan](https://github.com/underscorgan))

## [1.8.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.8.0) - 2015-03-17

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.7.0...1.8.0)

### Added

- Allow changing legacy_origin [#463](https://github.com/puppetlabs/puppetlabs-apt/pull/463) ([underscorgan](https://github.com/underscorgan))
- initial commit for apt_key checking [#459](https://github.com/puppetlabs/puppetlabs-apt/pull/459) ([tphoney](https://github.com/tphoney))
- apt::source: Merge `include_*` options into hash. [#451](https://github.com/puppetlabs/puppetlabs-apt/pull/451) ([daenney](https://github.com/daenney))
- apt::params: Complete $xfacts. [#450](https://github.com/puppetlabs/puppetlabs-apt/pull/450) ([daenney](https://github.com/daenney))
- apt: Add proxy support on the class. [#446](https://github.com/puppetlabs/puppetlabs-apt/pull/446) ([daenney](https://github.com/daenney))
- proxy_* params were removed from class apt [#443](https://github.com/puppetlabs/puppetlabs-apt/pull/443) ([underscorgan](https://github.com/underscorgan))
- Add base_name parameter to apt::setting [#442](https://github.com/puppetlabs/puppetlabs-apt/pull/442) ([underscorgan](https://github.com/underscorgan))
- apt::params: Make the class private. [#438](https://github.com/puppetlabs/puppetlabs-apt/pull/438) ([daenney](https://github.com/daenney))
- apt: Add apt::setting defined type. [#428](https://github.com/puppetlabs/puppetlabs-apt/pull/428) ([daenney](https://github.com/daenney))
- Add support for parameter trusted MODULES-1658 [#407](https://github.com/puppetlabs/puppetlabs-apt/pull/407) ([mkrakowitzer](https://github.com/mkrakowitzer))
- Allow full length GPG key fingerprints. [#404](https://github.com/puppetlabs/puppetlabs-apt/pull/404) ([WolverineFan](https://github.com/WolverineFan))
- Allow ports that consist of 5 decimals [#400](https://github.com/puppetlabs/puppetlabs-apt/pull/400) ([voidus](https://github.com/voidus))
- Add Ubuntu vivid (15.04) release [#395](https://github.com/puppetlabs/puppetlabs-apt/pull/395) ([udienz](https://github.com/udienz))

### Changed
- Various major behavioural changes [#447](https://github.com/puppetlabs/puppetlabs-apt/pull/447) ([daenney](https://github.com/daenney))
- V2.0.0 Prep work: Removing old code / Adding placeholders [#424](https://github.com/puppetlabs/puppetlabs-apt/pull/424) ([underscorgan](https://github.com/underscorgan))

### Fixed

- Update all the unit tests to look for full fingerprints [#469](https://github.com/puppetlabs/puppetlabs-apt/pull/469) ([underscorgan](https://github.com/underscorgan))
- apt_key: fix parsing invalid dates when using GnuPG 2.x [#465](https://github.com/puppetlabs/puppetlabs-apt/pull/465) ([bootc](https://github.com/bootc))
- Inheritance of apt::params means it can't be private [#461](https://github.com/puppetlabs/puppetlabs-apt/pull/461) ([underscorgan](https://github.com/underscorgan))
- Cleaning 50unattended-upgrades.erb [#456](https://github.com/puppetlabs/puppetlabs-apt/pull/456) ([johanfleury](https://github.com/johanfleury))
- MODULES-1827 adding Cumulus Linux detection [#454](https://github.com/puppetlabs/puppetlabs-apt/pull/454) ([LeslieCarr](https://github.com/LeslieCarr))
- apt::source: Make location required. [#453](https://github.com/puppetlabs/puppetlabs-apt/pull/453) ([daenney](https://github.com/daenney))
- apt::source: Rename `trusted_source`. [#452](https://github.com/puppetlabs/puppetlabs-apt/pull/452) ([daenney](https://github.com/daenney))
- apt: Fix all strict variable cases. [#449](https://github.com/puppetlabs/puppetlabs-apt/pull/449) ([daenney](https://github.com/daenney))
- apt::setting: Remove file_perms. [#448](https://github.com/puppetlabs/puppetlabs-apt/pull/448) ([daenney](https://github.com/daenney))
- Make apt::setting notify Exec['apt_update'] by default [#445](https://github.com/puppetlabs/puppetlabs-apt/pull/445) ([underscorgan](https://github.com/underscorgan))
- apt::setting: Parse type and name from title. [#444](https://github.com/puppetlabs/puppetlabs-apt/pull/444) ([daenney](https://github.com/daenney))
- Convert to use apt::setting instead of file resource [#441](https://github.com/puppetlabs/puppetlabs-apt/pull/441) ([underscorgan](https://github.com/underscorgan))
- Type is a reserved word in puppet 4 [#435](https://github.com/puppetlabs/puppetlabs-apt/pull/435) ([underscorgan](https://github.com/underscorgan))
- Stop redeclaring variables from params [#431](https://github.com/puppetlabs/puppetlabs-apt/pull/431) ([underscorgan](https://github.com/underscorgan))
- Remove 'include apt::update' [#429](https://github.com/puppetlabs/puppetlabs-apt/pull/429) ([underscorgan](https://github.com/underscorgan))
- RFC - Remove required packages [#427](https://github.com/puppetlabs/puppetlabs-apt/pull/427) ([underscorgan](https://github.com/underscorgan))
- apt::params: Add two missing entries, use them. [#426](https://github.com/puppetlabs/puppetlabs-apt/pull/426) ([daenney](https://github.com/daenney))
- Trusted will be a reserved word in Puppet 4 [#411](https://github.com/puppetlabs/puppetlabs-apt/pull/411) ([underscorgan](https://github.com/underscorgan))
- MODULES-1661 Fix to do delete with short key not long [#409](https://github.com/puppetlabs/puppetlabs-apt/pull/409) ([cyberious](https://github.com/cyberious))
- MODULES-1661 Fix issue with apt_key destroy, also added mutliple deletes [#408](https://github.com/puppetlabs/puppetlabs-apt/pull/408) ([cyberious](https://github.com/cyberious))
- Fix apt_has_updates fact not parsing apt-check output correctly [#403](https://github.com/puppetlabs/puppetlabs-apt/pull/403) ([WolverineFan](https://github.com/WolverineFan))
- Separate apt::pin for apt::backports to allow pin by release instead of ... [#398](https://github.com/puppetlabs/puppetlabs-apt/pull/398) ([riconnon](https://github.com/riconnon))
- (MODULES-1200) Fix inconsistent header across files [#389](https://github.com/puppetlabs/puppetlabs-apt/pull/389) ([stdietrich](https://github.com/stdietrich))
- MODULES-1119 Fixed to now have username and passwords passed in again [#384](https://github.com/puppetlabs/puppetlabs-apt/pull/384) ([cyberious](https://github.com/cyberious))
- Unattended upgrades oldstable for wheezy [#376](https://github.com/puppetlabs/puppetlabs-apt/pull/376) ([raoulbhatia](https://github.com/raoulbhatia))

## [1.7.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.7.0) - 2014-10-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.6.0...1.7.0)

### Added

- Add support for RandomSleep to 10periodic [#374](https://github.com/puppetlabs/puppetlabs-apt/pull/374) ([bschlief](https://github.com/bschlief))
- apt::force: Added 2 parameters for automatic configuration file handling... [#363](https://github.com/puppetlabs/puppetlabs-apt/pull/363) ([martinseener](https://github.com/martinseener))
- Apt update tooling [#349](https://github.com/puppetlabs/puppetlabs-apt/pull/349) ([wolfspyre](https://github.com/wolfspyre))

### Fixed

- Refactor facts to improve performance: [#375](https://github.com/puppetlabs/puppetlabs-apt/pull/375) ([raphink](https://github.com/raphink))
- add --force-yes so deb7 doesn't hang [#371](https://github.com/puppetlabs/puppetlabs-apt/pull/371) ([underscorgan](https://github.com/underscorgan))
- Fix for future parser support [#368](https://github.com/puppetlabs/puppetlabs-apt/pull/368) ([underscorgan](https://github.com/underscorgan))
- We aren't truncating in the type [#366](https://github.com/puppetlabs/puppetlabs-apt/pull/366) ([underscorgan](https://github.com/underscorgan))
- Don't truncate to short keys in the type [#365](https://github.com/puppetlabs/puppetlabs-apt/pull/365) ([underscorgan](https://github.com/underscorgan))
- Fix issue with puppet_module_install, removed and using updated method f... [#358](https://github.com/puppetlabs/puppetlabs-apt/pull/358) ([cyberious](https://github.com/cyberious))
- Remove stderr from stdout [#348](https://github.com/puppetlabs/puppetlabs-apt/pull/348) ([hunner](https://github.com/hunner))
- Builddep notifies apt-get update instead of requiring it [#326](https://github.com/puppetlabs/puppetlabs-apt/pull/326) ([dvcrn](https://github.com/dvcrn))

## [1.6.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.6.0) - 2014-08-13

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.5.2...1.6.0)

### Fixed

- Test fixes [#343](https://github.com/puppetlabs/puppetlabs-apt/pull/343) ([underscorgan](https://github.com/underscorgan))
- 1.5.3 backports [#340](https://github.com/puppetlabs/puppetlabs-apt/pull/340) ([underscorgan](https://github.com/underscorgan))
- Fix broken acceptance tests. [#335](https://github.com/puppetlabs/puppetlabs-apt/pull/335) ([underscorgan](https://github.com/underscorgan))
- Fix for debian/ubuntu hold and a way to add debian src only [#333](https://github.com/puppetlabs/puppetlabs-apt/pull/333) ([wilman0](https://github.com/wilman0))
- Fix inconsistent $proxy_host handling in apt and apt::ppa. [#330](https://github.com/puppetlabs/puppetlabs-apt/pull/330) ([dantman](https://github.com/dantman))
- Adds check to params.pp if lab-release is not installed [#329](https://github.com/puppetlabs/puppetlabs-apt/pull/329) ([spuder](https://github.com/spuder))

## [1.5.2](https://github.com/puppetlabs/puppetlabs-apt/tree/1.5.2) - 2014-07-21

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.5.1...1.5.2)

## [1.5.1](https://github.com/puppetlabs/puppetlabs-apt/tree/1.5.1) - 2014-07-10

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.5.0...1.5.1)

### Added

- Enable auto-update for Debian squeeze-lts [#321](https://github.com/puppetlabs/puppetlabs-apt/pull/321) ([raoulbhatia](https://github.com/raoulbhatia))
- add facts showing available updates [#319](https://github.com/puppetlabs/puppetlabs-apt/pull/319) ([damoxc](https://github.com/damoxc))
- Allow for custom comment in sources.list file [#311](https://github.com/puppetlabs/puppetlabs-apt/pull/311) ([juniorsysadmin](https://github.com/juniorsysadmin))

### Fixed

- MODULES-780 Don't blow up on unicode characters. [#327](https://github.com/puppetlabs/puppetlabs-apt/pull/327) ([adik](https://github.com/adik))
- MODULES-780 Don't blow up on unicode characters. [#318](https://github.com/puppetlabs/puppetlabs-apt/pull/318) ([daenney](https://github.com/daenney))

## [1.5.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.5.0) - 2014-06-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.4.2...1.5.0)

### Added

- adding notice on top of sourceslist files [#297](https://github.com/puppetlabs/puppetlabs-apt/pull/297) ([frconil](https://github.com/frconil))
- backports: Allow setting a custom priority. [#275](https://github.com/puppetlabs/puppetlabs-apt/pull/275) ([daenney](https://github.com/daenney))
- apt::hold: Add a mechanism to hold a package. [#259](https://github.com/puppetlabs/puppetlabs-apt/pull/259) ([daenney](https://github.com/daenney))
- Add Ubuntu Trusty [#258](https://github.com/puppetlabs/puppetlabs-apt/pull/258) ([sodabrew](https://github.com/sodabrew))
- Add ability to specify hash of apt sources in hiera [#249](https://github.com/puppetlabs/puppetlabs-apt/pull/249) ([ghoneycutt](https://github.com/ghoneycutt))
- Rework apt::key to use apt_key. [#230](https://github.com/puppetlabs/puppetlabs-apt/pull/230) ([daenney](https://github.com/daenney))

### Fixed

- Fixed regex to follow APT requirements [#298](https://github.com/puppetlabs/puppetlabs-apt/pull/298) ([frconil](https://github.com/frconil))
- unattended_upgrades: Fix matching security archive [#286](https://github.com/puppetlabs/puppetlabs-apt/pull/286) ([apenney](https://github.com/apenney))
- Change proxy's configuration file to be consistent with other config files in apt.conf.d [#283](https://github.com/puppetlabs/puppetlabs-apt/pull/283) ([johanfleury](https://github.com/johanfleury))
- unattended-upgrades: Fix origins for Squeeze. [#281](https://github.com/puppetlabs/puppetlabs-apt/pull/281) ([daenney](https://github.com/daenney))
- Small patch to fix the spacing that makes lint fail. [#279](https://github.com/puppetlabs/puppetlabs-apt/pull/279) ([apenney](https://github.com/apenney))
- unattended_upgrades: Fix matching security archive [#278](https://github.com/puppetlabs/puppetlabs-apt/pull/278) ([daenney](https://github.com/daenney))
- Fix typo in ppa.pp [#274](https://github.com/puppetlabs/puppetlabs-apt/pull/274) ([fdrouet](https://github.com/fdrouet))
- Use File.expand_path with require. [#268](https://github.com/puppetlabs/puppetlabs-apt/pull/268) ([daenney](https://github.com/daenney))
- Fix fail message [#248](https://github.com/puppetlabs/puppetlabs-apt/pull/248) ([electrical](https://github.com/electrical))
- Make apt.conf.d/proxy world readable and add a newline [#209](https://github.com/puppetlabs/puppetlabs-apt/pull/209) ([pabl0](https://github.com/pabl0))
- Added retry to update operation [#193](https://github.com/puppetlabs/puppetlabs-apt/pull/193) ([ianunruh](https://github.com/ianunruh))

## [1.4.2](https://github.com/puppetlabs/puppetlabs-apt/tree/1.4.2) - 2014-03-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.4.1...1.4.2)

### Added

- Add lsbdistid facts where appropriate. [#244](https://github.com/puppetlabs/puppetlabs-apt/pull/244) ([apenney](https://github.com/apenney))
- apt: Allow managing of preferences file. [#240](https://github.com/puppetlabs/puppetlabs-apt/pull/240) ([daenney](https://github.com/daenney))
- apt_key: Support fetching keys over FTP. [#229](https://github.com/puppetlabs/puppetlabs-apt/pull/229) ([daenney](https://github.com/daenney))
- apt::pin: Allow for packages to be an array. [#223](https://github.com/puppetlabs/puppetlabs-apt/pull/223) ([daenney](https://github.com/daenney))

### Fixed

- Add back in missing fields to work around Puppet bug. [#257](https://github.com/puppetlabs/puppetlabs-apt/pull/257) ([apenney](https://github.com/apenney))
- Port 8080 is a bad choice and bumps into puppetdb [#237](https://github.com/puppetlabs/puppetlabs-apt/pull/237) ([hunner](https://github.com/hunner))
- Don't pass options to ppa on lucid [#231](https://github.com/puppetlabs/puppetlabs-apt/pull/231) ([hunner](https://github.com/hunner))
- Force owner and mode on ppa files [#227](https://github.com/puppetlabs/puppetlabs-apt/pull/227) ([daniellawrence](https://github.com/daniellawrence))
- Update out of date Debian signing key for backports [#226](https://github.com/puppetlabs/puppetlabs-apt/pull/226) ([mark0n](https://github.com/mark0n))
- changed proxy_host default value from true to undef. fixes #211 [#215](https://github.com/puppetlabs/puppetlabs-apt/pull/215) ([lotherk](https://github.com/lotherk))

## [1.4.1](https://github.com/puppetlabs/puppetlabs-apt/tree/1.4.1) - 2014-02-14

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.4.0...1.4.1)

### Added

- Update ppa.pp [#191](https://github.com/puppetlabs/puppetlabs-apt/pull/191) ([mnencia](https://github.com/mnencia))

### Changed
- Handling of release parameter and apt provider in force manifest [#140](https://github.com/puppetlabs/puppetlabs-apt/pull/140) ([hunner](https://github.com/hunner))

### Fixed

- Ensure apt::ppa fails on non-Ubuntu. [#208](https://github.com/puppetlabs/puppetlabs-apt/pull/208) ([apenney](https://github.com/apenney))
- fixed include, contained dash instead of underline. [#205](https://github.com/puppetlabs/puppetlabs-apt/pull/205) ([braddeicide](https://github.com/braddeicide))
- Apt::ppa should exec with root [#202](https://github.com/puppetlabs/puppetlabs-apt/pull/202) ([tsuharesu](https://github.com/tsuharesu))
- Use include instead of parameterized class when no params are given. [#187](https://github.com/puppetlabs/puppetlabs-apt/pull/187) ([ghoneycutt](https://github.com/ghoneycutt))
- add an 'ensure' parameter to apt::ppa [#184](https://github.com/puppetlabs/puppetlabs-apt/pull/184) ([rsrchboy](https://github.com/rsrchboy))
- apt::source templates/sources.list.erb generates invalid source line when architecture is provided. [#182](https://github.com/puppetlabs/puppetlabs-apt/pull/182) ([stefanvanwouw](https://github.com/stefanvanwouw))
- getparam() isn't available in all stdlib versions. [#178](https://github.com/puppetlabs/puppetlabs-apt/pull/178) ([apenney](https://github.com/apenney))

## [1.4.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.4.0) - 2013-10-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.3.0...1.4.0)

### Fixed

- This work flips from onlyif to unless (mistakenly looked at the [#172](https://github.com/puppetlabs/puppetlabs-apt/pull/172) ([apenney](https://github.com/apenney))
- add an updates_timeout option to apt::params (PR fix) [#167](https://github.com/puppetlabs/puppetlabs-apt/pull/167) ([madeddie](https://github.com/madeddie))

## [1.3.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.3.0) - 2013-09-17

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.2.0...1.3.0)

### Added

- Class for managing unattended-upgrades [#153](https://github.com/puppetlabs/puppetlabs-apt/pull/153) ([philipcohoe](https://github.com/philipcohoe))
- Add wheezy backports support [#149](https://github.com/puppetlabs/puppetlabs-apt/pull/149) ([bionix](https://github.com/bionix))

### Fixed

- pass flags as string of single letter [#148](https://github.com/puppetlabs/puppetlabs-apt/pull/148) ([nagas](https://github.com/nagas))
- Fix: parametrize apt::ppa class for beign able to pass options to apt-add-repository command [#146](https://github.com/puppetlabs/puppetlabs-apt/pull/146) ([oleiade](https://github.com/oleiade))
- ppa: fix empty environment definition in exec ressource when no proxy [#145](https://github.com/puppetlabs/puppetlabs-apt/pull/145) ([PierreGambarotto](https://github.com/PierreGambarotto))

## [1.2.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.2.0) - 2013-07-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.1.1...1.2.0)

### Added

- Add a $key_options parameter to apt::key. [#122](https://github.com/puppetlabs/puppetlabs-apt/pull/122) ([strangeman](https://github.com/strangeman))
- Add optional architecture qualifier to apt-sources [#118](https://github.com/puppetlabs/puppetlabs-apt/pull/118) ([jopecko](https://github.com/jopecko))

### Fixed

- replace aptitude with apt in apt::force [#134](https://github.com/puppetlabs/puppetlabs-apt/pull/134) ([spali](https://github.com/spali))

## [1.1.1](https://github.com/puppetlabs/puppetlabs-apt/tree/1.1.1) - 2013-07-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.1.0...1.1.1)

### Added

- Support APT pinning by codename [#135](https://github.com/puppetlabs/puppetlabs-apt/pull/135) ([vholer](https://github.com/vholer))

### Fixed

- Revert "Merge pull request #135 from CERIT-SC/master" [#137](https://github.com/puppetlabs/puppetlabs-apt/pull/137) ([hunner](https://github.com/hunner))
- trim keys to 8 chars for matching with apt-key list (fix for #100) [#133](https://github.com/puppetlabs/puppetlabs-apt/pull/133) ([benben](https://github.com/benben))

## [1.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.1.0) - 2012-12-02

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.0.1...1.1.0)

### Fixed

- Modified the PPA code for changes in Quantal [#96](https://github.com/puppetlabs/puppetlabs-apt/pull/96) ([jnicolson](https://github.com/jnicolson))
- Librarian bug [#94](https://github.com/puppetlabs/puppetlabs-apt/pull/94) ([ryanycoleman](https://github.com/ryanycoleman))

## [1.0.1](https://github.com/puppetlabs/puppetlabs-apt/tree/1.0.1) - 2012-10-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.0.0...1.0.1)

## [1.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.0.0) - 2012-10-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/0.0.4...1.0.0)

### Added

- (#16070) Allow optional order parameter to apt::pin [#83](https://github.com/puppetlabs/puppetlabs-apt/pull/83) ([dalen](https://github.com/dalen))
- Add a way to specify a timeout for the apt::force define. [#79](https://github.com/puppetlabs/puppetlabs-apt/pull/79) ([sathlan](https://github.com/sathlan))

### Fixed

- remove check, if $release is empty [#78](https://github.com/puppetlabs/puppetlabs-apt/pull/78) ([saz](https://github.com/saz))
- «main» repository is missing from ubuntu backports. [#77](https://github.com/puppetlabs/puppetlabs-apt/pull/77) ([jonhattan](https://github.com/jonhattan))
- fix scoping of $lsbdistcodename in source.pp [#74](https://github.com/puppetlabs/puppetlabs-apt/pull/74) ([antonlindstrom](https://github.com/antonlindstrom))
- Add logoutput on_failure for all exec resources. [#73](https://github.com/puppetlabs/puppetlabs-apt/pull/73) ([nanliu](https://github.com/nanliu))
- Fix Modulefile for puppet-apt to puppetlabs-apt rename [#72](https://github.com/puppetlabs/puppetlabs-apt/pull/72) ([branan](https://github.com/branan))

## [0.0.4](https://github.com/puppetlabs/puppetlabs-apt/tree/0.0.4) - 2012-06-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/0.0.3...0.0.4)

### Fixed

- Fix Modulefile for puppet-apt to puppetlabs-apt rename [#72](https://github.com/puppetlabs/puppetlabs-apt/pull/72) ([branan](https://github.com/branan))
- (#14657) Fix filename when there is a period in the PPA [#60](https://github.com/puppetlabs/puppetlabs-apt/pull/60) ([branan](https://github.com/branan))
- Fix style related issues in module. [#57](https://github.com/puppetlabs/puppetlabs-apt/pull/57) ([nanliu](https://github.com/nanliu))
- (#11966) apt module containment for apt_update. [#55](https://github.com/puppetlabs/puppetlabs-apt/pull/55) ([nanliu](https://github.com/nanliu))

## [0.0.3](https://github.com/puppetlabs/puppetlabs-apt/tree/0.0.3) - 2012-05-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/0.0.2...0.0.3)

### Added

- (#14321) apt::pin resource support release. [#53](https://github.com/puppetlabs/puppetlabs-apt/pull/53) ([nanliu](https://github.com/nanliu))
- (#14308) Add ensure=>absent for define resource. [#52](https://github.com/puppetlabs/puppetlabs-apt/pull/52) ([nanliu](https://github.com/nanliu))
- Sync with pl ops [#42](https://github.com/puppetlabs/puppetlabs-apt/pull/42) ([ody](https://github.com/ody))
- Make sure we configure the proxy before doing apt-get update. [#41](https://github.com/puppetlabs/puppetlabs-apt/pull/41) ([tbroyer](https://github.com/tbroyer))

### Fixed

- Move Package['python-software-properties'] to apt:ppa [#54](https://github.com/puppetlabs/puppetlabs-apt/pull/54) ([branan](https://github.com/branan))
- (#11966) Only invoke apt-get update once. [#49](https://github.com/puppetlabs/puppetlabs-apt/pull/49) ([nanliu](https://github.com/nanliu))
- (#14138) Fix spec test for aptitude changes. [#47](https://github.com/puppetlabs/puppetlabs-apt/pull/47) ([nanliu](https://github.com/nanliu))
- (#14138) Modify apt::ppa's update-apt exec to use the ${apt::params::provider} parameter. [#44](https://github.com/puppetlabs/puppetlabs-apt/pull/44) ([relud](https://github.com/relud))

## [0.0.2](https://github.com/puppetlabs/puppetlabs-apt/tree/0.0.2) - 2012-03-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/0.0.1...0.0.2)

### Added

- (#13125) Apt keys should be case insensitive [#34](https://github.com/puppetlabs/puppetlabs-apt/pull/34) ([blkperl](https://github.com/blkperl))

### Fixed

- Convert apt::key to use anchors [#32](https://github.com/puppetlabs/puppetlabs-apt/pull/32) ([reidmv](https://github.com/reidmv))

## [0.0.1](https://github.com/puppetlabs/puppetlabs-apt/tree/0.0.1) - 2012-03-07

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/f848bac6072f99e1cd60a0cc0b84e5679c598dab...0.0.1)

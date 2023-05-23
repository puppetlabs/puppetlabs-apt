<!-- markdownlint-disable MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v10.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/v10.0.0) - 2023-05-23

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/v9.0.2...v10.0.0)

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

### Added

- enable allow-insecure for apt::source defined types, includes new tes… [#1014](https://github.com/puppetlabs/puppetlabs-apt/pull/1014) ([hesco](https://github.com/hesco))

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

### Added

- (MODULES-11173) Add per-host overrides for apt::proxy [#1007](https://github.com/puppetlabs/puppetlabs-apt/pull/1007) ([maturnbull](https://github.com/maturnbull))

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
- Add apt::key_options for default apt::key options [#873](https://github.com/puppetlabs/puppetlabs-apt/pull/873) ([raphink](https://github.com/raphink))
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

- Add support for dist-upgrade & autoremove action [#832](https://github.com/puppetlabs/puppetlabs-apt/pull/832) ([aboks](https://github.com/aboks))
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

### Other

- (MODULES-6476) - Release prep apt 4.5.0 [#741](https://github.com/puppetlabs/puppetlabs-apt/pull/741) ([pmcmaw](https://github.com/pmcmaw))
- (MODULES-6452) - PDK Convert apt [#740](https://github.com/puppetlabs/puppetlabs-apt/pull/740) ([pmcmaw](https://github.com/pmcmaw))
- (maint) - Addressing puppet-lint doc warnings [#739](https://github.com/puppetlabs/puppetlabs-apt/pull/739) ([pmcmaw](https://github.com/pmcmaw))
- (maint) modulesync 65530a4 Update Travis [#738](https://github.com/puppetlabs/puppetlabs-apt/pull/738) ([michaeltlombardi](https://github.com/michaeltlombardi))
- Modulesync rubocop [#737](https://github.com/puppetlabs/puppetlabs-apt/pull/737) ([willmeek](https://github.com/willmeek))
- (maint) - modulesync 384f4c1 [#736](https://github.com/puppetlabs/puppetlabs-apt/pull/736) ([tphoney](https://github.com/tphoney))
- MODULES-6235 - Addressing Rubocop Errors [#735](https://github.com/puppetlabs/puppetlabs-apt/pull/735) ([pmcmaw](https://github.com/pmcmaw))
- Release merge back 4.4.1 [#734](https://github.com/puppetlabs/puppetlabs-apt/pull/734) ([pmcmaw](https://github.com/pmcmaw))

## [4.4.1](https://github.com/puppetlabs/puppetlabs-apt/tree/4.4.1) - 2017-11-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.4.0...4.4.1)

### Other

- (maint) - modulesync 1d81b6a [#733](https://github.com/puppetlabs/puppetlabs-apt/pull/733) ([pmcmaw](https://github.com/pmcmaw))
- Release prep for 4.4.1 [#732](https://github.com/puppetlabs/puppetlabs-apt/pull/732) ([willmeek](https://github.com/willmeek))
- Rubocopification [#731](https://github.com/puppetlabs/puppetlabs-apt/pull/731) ([willmeek](https://github.com/willmeek))
- Release mergeback 4.4.0 [#730](https://github.com/puppetlabs/puppetlabs-apt/pull/730) ([pmcmaw](https://github.com/pmcmaw))

## [4.4.0](https://github.com/puppetlabs/puppetlabs-apt/tree/4.4.0) - 2017-11-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.3.0...4.4.0)

### Added

- Http proxy bypass [#718](https://github.com/puppetlabs/puppetlabs-apt/pull/718) ([willmeek](https://github.com/willmeek))

### Other

- fix inconsistencies in README [#729](https://github.com/puppetlabs/puppetlabs-apt/pull/729) ([jbondpdx](https://github.com/jbondpdx))
- Further release prep for 4.4.0 [#728](https://github.com/puppetlabs/puppetlabs-apt/pull/728) ([willmeek](https://github.com/willmeek))
- install apt-transport-https on Debian 7 as well [#724](https://github.com/puppetlabs/puppetlabs-apt/pull/724) ([wyardley](https://github.com/wyardley))
- Fix numbering in README index [#723](https://github.com/puppetlabs/puppetlabs-apt/pull/723) ([wyardley](https://github.com/wyardley))
- Add a check for Puppet version to task helper [#722](https://github.com/puppetlabs/puppetlabs-apt/pull/722) ([willmeek](https://github.com/willmeek))
- Release prep for 4.4.0 [#721](https://github.com/puppetlabs/puppetlabs-apt/pull/721) ([willmeek](https://github.com/willmeek))
- Install apt-transport-https if needed [#720](https://github.com/puppetlabs/puppetlabs-apt/pull/720) ([btravouillon](https://github.com/btravouillon))
- Add a facter fact for dist-upgrade [#719](https://github.com/puppetlabs/puppetlabs-apt/pull/719) ([willmeek](https://github.com/willmeek))
- Remove tasks acceptance test for non-Debian builds [#717](https://github.com/puppetlabs/puppetlabs-apt/pull/717) ([willmeek](https://github.com/willmeek))
- Do not treat debian stable-updates as security updates [#716](https://github.com/puppetlabs/puppetlabs-apt/pull/716) ([kbarmen](https://github.com/kbarmen))
- Install apt-transport-https in Debian 8 if needed [#714](https://github.com/puppetlabs/puppetlabs-apt/pull/714) ([btravouillon](https://github.com/btravouillon))
- Update link to Release in CHANGELOG [#713](https://github.com/puppetlabs/puppetlabs-apt/pull/713) ([willmeek](https://github.com/willmeek))
- 4.3.0 merge back to master [#712](https://github.com/puppetlabs/puppetlabs-apt/pull/712) ([tphoney](https://github.com/tphoney))
- remove legacy functions [#711](https://github.com/puppetlabs/puppetlabs-apt/pull/711) ([b4ldr](https://github.com/b4ldr))
- Fixed circular dependency for package dirmngr [#710](https://github.com/puppetlabs/puppetlabs-apt/pull/710) ([hp197](https://github.com/hp197))

## [4.3.0](https://github.com/puppetlabs/puppetlabs-apt/tree/4.3.0) - 2017-10-11

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.2.0...4.3.0)

### Other

- (MODULES-5628) 4.2.0 release merge back [#709](https://github.com/puppetlabs/puppetlabs-apt/pull/709) ([HAIL9000](https://github.com/HAIL9000))
- Cleanup ruby code via rubocop. [#706](https://github.com/puppetlabs/puppetlabs-apt/pull/706) ([tphoney](https://github.com/tphoney))
- (MODULES-4265) Detect security updates from multiple sources [#651](https://github.com/puppetlabs/puppetlabs-apt/pull/651) ([nhinds](https://github.com/nhinds))

## [4.2.0](https://github.com/puppetlabs/puppetlabs-apt/tree/4.2.0) - 2017-09-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.1.0...4.2.0)

### Other

- (maint) update changelog entry for support/compat clarification [skip ci] [#708](https://github.com/puppetlabs/puppetlabs-apt/pull/708) ([eputnam](https://github.com/eputnam))
- minor edits to new material [#707](https://github.com/puppetlabs/puppetlabs-apt/pull/707) ([jbondpdx](https://github.com/jbondpdx))
- (MODULES-5628) 4.2.0 release prep [#705](https://github.com/puppetlabs/puppetlabs-apt/pull/705) ([HAIL9000](https://github.com/HAIL9000))
- (maint) Update release merge back [#704](https://github.com/puppetlabs/puppetlabs-apt/pull/704) ([HAIL9000](https://github.com/HAIL9000))
- apt_package_security_updates fact and test [#703](https://github.com/puppetlabs/puppetlabs-apt/pull/703) ([tphoney](https://github.com/tphoney))
- Switch to deb.debian.org and remove Debian 6.0 [#702](https://github.com/puppetlabs/puppetlabs-apt/pull/702) ([tphoney](https://github.com/tphoney))
- (maint) modulesync 892c4cf [#701](https://github.com/puppetlabs/puppetlabs-apt/pull/701) ([HAIL9000](https://github.com/HAIL9000))
- Delete documentation for parameters that already has been removed [#700](https://github.com/puppetlabs/puppetlabs-apt/pull/700) ([deric](https://github.com/deric))
- MODULES-4686: gpg keyserver import fails in Debian 9 (Stretch) [#698](https://github.com/puppetlabs/puppetlabs-apt/pull/698) ([deric](https://github.com/deric))
- fix documentation for parameter $proxy['port'] in class apt [#697](https://github.com/puppetlabs/puppetlabs-apt/pull/697) ([aeber](https://github.com/aeber))
- Add 16.04 to list of distributions that should use software-properties-common. [#696](https://github.com/puppetlabs/puppetlabs-apt/pull/696) ([trevorrea](https://github.com/trevorrea))
- (FM-6273) - Removing Debian 6 [#695](https://github.com/puppetlabs/puppetlabs-apt/pull/695) ([pmcmaw](https://github.com/pmcmaw))
- (MODULES-5501) - Remove unsupported Ubuntu [#694](https://github.com/puppetlabs/puppetlabs-apt/pull/694) ([pmcmaw](https://github.com/pmcmaw))
- Fixed typo in "Configuring Apt from hiera example" [#693](https://github.com/puppetlabs/puppetlabs-apt/pull/693) ([morremeyer](https://github.com/morremeyer))
- (maint) modulesync 915cde70e20 [#692](https://github.com/puppetlabs/puppetlabs-apt/pull/692) ([glennsarti](https://github.com/glennsarti))
- Allow user to modify loglevel of apt-get update Exec resource [#690](https://github.com/puppetlabs/puppetlabs-apt/pull/690) ([tpdownes](https://github.com/tpdownes))
- (MODULES-5187) mysnc puppet 5 and ruby 2.4 [#688](https://github.com/puppetlabs/puppetlabs-apt/pull/688) ([eputnam](https://github.com/eputnam))
- Fix broken markdown of CHANGELOG.md [#687](https://github.com/puppetlabs/puppetlabs-apt/pull/687) ([hfm](https://github.com/hfm))
- (MODULES-5144) Prep for puppet 5 [#686](https://github.com/puppetlabs/puppetlabs-apt/pull/686) ([hunner](https://github.com/hunner))
- Release 4.1.0 Mergeback [#684](https://github.com/puppetlabs/puppetlabs-apt/pull/684) ([HelenCampbell](https://github.com/HelenCampbell))
- (maint) Add bugfix to changelog [#675](https://github.com/puppetlabs/puppetlabs-apt/pull/675) ([hunner](https://github.com/hunner))
- Ignore subkeys in apt-key's output [#665](https://github.com/puppetlabs/puppetlabs-apt/pull/665) ([tiger-jmw](https://github.com/tiger-jmw))
- This class should be private [#657](https://github.com/puppetlabs/puppetlabs-apt/pull/657) ([binford2k](https://github.com/binford2k))
- (MODULES-4118) Set dpkg option NoLocking in apt_updates fact [#640](https://github.com/puppetlabs/puppetlabs-apt/pull/640) ([jocado](https://github.com/jocado))

## [4.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/4.1.0) - 2017-06-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/4.0.0...4.1.0)

### Other

- 4.1.0 Release Prep [#683](https://github.com/puppetlabs/puppetlabs-apt/pull/683) ([HelenCampbell](https://github.com/HelenCampbell))
- (maint) fix incorrect error message [#682](https://github.com/puppetlabs/puppetlabs-apt/pull/682) ([eputnam](https://github.com/eputnam))
- Ensure release allows empty strings [#681](https://github.com/puppetlabs/puppetlabs-apt/pull/681) ([HelenCampbell](https://github.com/HelenCampbell))
- (MODULES-4973) rip out data in modules [#680](https://github.com/puppetlabs/puppetlabs-apt/pull/680) ([eputnam](https://github.com/eputnam))
- Fix typo in hiera example [#679](https://github.com/puppetlabs/puppetlabs-apt/pull/679) ([arioch](https://github.com/arioch))
- Revert removal of Evolving Web's attribution in NOTICE file [#678](https://github.com/puppetlabs/puppetlabs-apt/pull/678) ([DavidS](https://github.com/DavidS))
- (#4913) apt_key now does not always send auth basic [#677](https://github.com/puppetlabs/puppetlabs-apt/pull/677) ([stefanandres](https://github.com/stefanandres))
- 4.0.0 Mergeback [#676](https://github.com/puppetlabs/puppetlabs-apt/pull/676) ([hunner](https://github.com/hunner))

## [4.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/4.0.0) - 2017-04-27

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/3.0.0...4.0.0)

### Other

- (maint) Fix for different versions [#674](https://github.com/puppetlabs/puppetlabs-apt/pull/674) ([hunner](https://github.com/hunner))
- Rebase of #668 [#673](https://github.com/puppetlabs/puppetlabs-apt/pull/673) ([hunner](https://github.com/hunner))
- Fix architecture fact overriding unset `architecture` source option [#672](https://github.com/puppetlabs/puppetlabs-apt/pull/672) ([domcleal](https://github.com/domcleal))
- Release Mergeback [#671](https://github.com/puppetlabs/puppetlabs-apt/pull/671) ([tphoney](https://github.com/tphoney))

## [3.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/3.0.0) - 2017-04-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.4.0...3.0.0)

### Other

- (PUP-6856) Always define facts [#670](https://github.com/puppetlabs/puppetlabs-apt/pull/670) ([hunner](https://github.com/hunner))
- Release Mergeback [#669](https://github.com/puppetlabs/puppetlabs-apt/pull/669) ([HelenCampbell](https://github.com/HelenCampbell))
- First Release prep for Puppet 4 language update [#667](https://github.com/puppetlabs/puppetlabs-apt/pull/667) ([HelenCampbell](https://github.com/HelenCampbell))

## [2.4.0](https://github.com/puppetlabs/puppetlabs-apt/tree/2.4.0) - 2017-04-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.3.0...2.4.0)

### Other

- 2.4.0 Release Prep [#666](https://github.com/puppetlabs/puppetlabs-apt/pull/666) ([HelenCampbell](https://github.com/HelenCampbell))
- [msync] 786266 Implement puppet-module-gems, a45803 Remove metadata.json from locales config [#662](https://github.com/puppetlabs/puppetlabs-apt/pull/662) ([wilson208](https://github.com/wilson208))
- [MODULES-4528] Replace Puppet.version.to_f version comparison from spec_helper.rb [#660](https://github.com/puppetlabs/puppetlabs-apt/pull/660) ([wilson208](https://github.com/wilson208))
- [MODULES-4528] Replace Puppet.version.to_f with Puppet::Util::Package.versioncmp [#658](https://github.com/puppetlabs/puppetlabs-apt/pull/658) ([wilson208](https://github.com/wilson208))
- apt::key is a defined type, not a class [#656](https://github.com/puppetlabs/puppetlabs-apt/pull/656) ([WhatsARanjit](https://github.com/WhatsARanjit))
- (MODULES-4098) Sync the rest of the files [#654](https://github.com/puppetlabs/puppetlabs-apt/pull/654) ([hunner](https://github.com/hunner))
- remove unnecessary comma in example [#653](https://github.com/puppetlabs/puppetlabs-apt/pull/653) ([Cosaquee](https://github.com/Cosaquee))
- [MODULES-4224] Implement beaker-module_install_helper [#652](https://github.com/puppetlabs/puppetlabs-apt/pull/652) ([wilson208](https://github.com/wilson208))
- (MODULES-4097) Sync travis.yml [#650](https://github.com/puppetlabs/puppetlabs-apt/pull/650) ([hunner](https://github.com/hunner))
- (FM-5972) gettext and spec.opts [#646](https://github.com/puppetlabs/puppetlabs-apt/pull/646) ([eputnam](https://github.com/eputnam))
- (maint) updates spec.opts in prep for parallel_spec [#644](https://github.com/puppetlabs/puppetlabs-apt/pull/644) ([eputnam](https://github.com/eputnam))
- (MODULES-3631) msync Gemfile for 1.9 frozen strings [#643](https://github.com/puppetlabs/puppetlabs-apt/pull/643) ([hunner](https://github.com/hunner))
- Use stdlib deprecation [#641](https://github.com/puppetlabs/puppetlabs-apt/pull/641) ([DavidS](https://github.com/DavidS))
- remove port number from hostname [#638](https://github.com/puppetlabs/puppetlabs-apt/pull/638) ([lrrb](https://github.com/lrrb))
- (MODULES-3704) Update gemfile template to be identical [#636](https://github.com/puppetlabs/puppetlabs-apt/pull/636) ([hunner](https://github.com/hunner))
- Avoid string comparison error [#635](https://github.com/puppetlabs/puppetlabs-apt/pull/635) ([lkoranda](https://github.com/lkoranda))
- (MODULES-3983) Update parallel_tests for ruby 2.0.0 [#633](https://github.com/puppetlabs/puppetlabs-apt/pull/633) ([pmcmaw](https://github.com/pmcmaw))
- [MODULES-3562] Implement retry for tests which require modules to pull key from keyserver [#631](https://github.com/puppetlabs/puppetlabs-apt/pull/631) ([wilson208](https://github.com/wilson208))
- Update modulesync_config [51f469d] [#629](https://github.com/puppetlabs/puppetlabs-apt/pull/629) ([DavidS](https://github.com/DavidS))
- Undef default for $notify_update in source.pp results in problem with Puppet 3.7.2 [#628](https://github.com/puppetlabs/puppetlabs-apt/pull/628) ([cpavanrun](https://github.com/cpavanrun))
- Release Mergeback [#627](https://github.com/puppetlabs/puppetlabs-apt/pull/627) ([HelenCampbell](https://github.com/HelenCampbell))

## [2.3.0](https://github.com/puppetlabs/puppetlabs-apt/tree/2.3.0) - 2016-09-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.2.2...2.3.0)

### Added

- Expose notify_update to apt::source [#596](https://github.com/puppetlabs/puppetlabs-apt/pull/596) ([danielhoherd](https://github.com/danielhoherd))

### Fixed

- Fixed "unless" test condition for ppa repository [#613](https://github.com/puppetlabs/puppetlabs-apt/pull/613) ([nicobn](https://github.com/nicobn))
- apt/params: Remove unused LSB facts [#610](https://github.com/puppetlabs/puppetlabs-apt/pull/610) ([daenney](https://github.com/daenney))
- Fix regexp for $ensure params [#609](https://github.com/puppetlabs/puppetlabs-apt/pull/609) ([hfm](https://github.com/hfm))

### Other

- (maint) Update the gpg key [#626](https://github.com/puppetlabs/puppetlabs-apt/pull/626) ([underscorgan](https://github.com/underscorgan))
- Release prep 2.3.0 [#625](https://github.com/puppetlabs/puppetlabs-apt/pull/625) ([HelenCampbell](https://github.com/HelenCampbell))
- Update modulesync_config [a3fe424] [#622](https://github.com/puppetlabs/puppetlabs-apt/pull/622) ([DavidS](https://github.com/DavidS))
- Update modulesync_config [0d59329] [#621](https://github.com/puppetlabs/puppetlabs-apt/pull/621) ([DavidS](https://github.com/DavidS))
- Fix syntax error [#619](https://github.com/puppetlabs/puppetlabs-apt/pull/619) ([DavidS](https://github.com/DavidS))
- (MAINT) Update for modulesync_config 72d19f184 [#618](https://github.com/puppetlabs/puppetlabs-apt/pull/618) ([DavidS](https://github.com/DavidS))
- (MODULES-3414) Limit non-strict parsing to pre-3.5.0 only [#617](https://github.com/puppetlabs/puppetlabs-apt/pull/617) ([hunner](https://github.com/hunner))
- Add ability to specify a hash of apt::conf defines [#616](https://github.com/puppetlabs/puppetlabs-apt/pull/616) ([ghoneycutt](https://github.com/ghoneycutt))
- (MODULES-3581) modulesync [067d08a] [#615](https://github.com/puppetlabs/puppetlabs-apt/pull/615) ([DavidS](https://github.com/DavidS))
- {maint} modulesync 0794b2c [#612](https://github.com/puppetlabs/puppetlabs-apt/pull/612) ([tphoney](https://github.com/tphoney))
- Fix TYPO [#611](https://github.com/puppetlabs/puppetlabs-apt/pull/611) ([mattkenn4545](https://github.com/mattkenn4545))
- Update tests to use the pool servers instead of ubuntu's [#608](https://github.com/puppetlabs/puppetlabs-apt/pull/608) ([DavidS](https://github.com/DavidS))
- Removal of a breaking test for Xenial [#607](https://github.com/puppetlabs/puppetlabs-apt/pull/607) ([HelenCampbell](https://github.com/HelenCampbell))
- Use hkps.pool.sks-keyservers.net instead of pgp.mit.edu [#606](https://github.com/puppetlabs/puppetlabs-apt/pull/606) ([DavidS](https://github.com/DavidS))
- Install software-properties-common for xenial [#605](https://github.com/puppetlabs/puppetlabs-apt/pull/605) ([imphil](https://github.com/imphil))
- Fix version check on 16.04. [#604](https://github.com/puppetlabs/puppetlabs-apt/pull/604) ([tdb](https://github.com/tdb))
- apt::setting expects priority to be an integer, set defaults accordingly [#602](https://github.com/puppetlabs/puppetlabs-apt/pull/602) ([madddi](https://github.com/madddi))
- Update to newest modulesync_configs [9ca280f] [#600](https://github.com/puppetlabs/puppetlabs-apt/pull/600) ([DavidS](https://github.com/DavidS))
- Fix STRICT_VARIABLE testing [#599](https://github.com/puppetlabs/puppetlabs-apt/pull/599) ([DavidS](https://github.com/DavidS))
- Typo: missing colon [#595](https://github.com/puppetlabs/puppetlabs-apt/pull/595) ([danielhoherd](https://github.com/danielhoherd))
- Mergeback 2.2.x [#593](https://github.com/puppetlabs/puppetlabs-apt/pull/593) ([bmjen](https://github.com/bmjen))
- Make apt_updates facts use /usr/bin/apt-get. [#581](https://github.com/puppetlabs/puppetlabs-apt/pull/581) ([robinelfrink](https://github.com/robinelfrink))

## [2.2.2](https://github.com/puppetlabs/puppetlabs-apt/tree/2.2.2) - 2016-02-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.2.1...2.2.2)

### Fixed

- MODULES-2873 - Avoid multiple package resource declarations [#588](https://github.com/puppetlabs/puppetlabs-apt/pull/588) ([werekraken](https://github.com/werekraken))
- Handle PPA names that contain a plus character. [#583](https://github.com/puppetlabs/puppetlabs-apt/pull/583) ([tdb](https://github.com/tdb))
- Fix apt_key tempfile race condition [#572](https://github.com/puppetlabs/puppetlabs-apt/pull/572) ([claytono](https://github.com/claytono))

### Other

- Prep for 2.2.2 Release [#592](https://github.com/puppetlabs/puppetlabs-apt/pull/592) ([HelenCampbell](https://github.com/HelenCampbell))
- Update metadata to note Debian 8 support [#590](https://github.com/puppetlabs/puppetlabs-apt/pull/590) ([DavidS](https://github.com/DavidS))
- (FM-4046) Update to current msync configs [006831f] [#589](https://github.com/puppetlabs/puppetlabs-apt/pull/589) ([DavidS](https://github.com/DavidS))
- MODULES-2941: add example to README [#587](https://github.com/puppetlabs/puppetlabs-apt/pull/587) ([jbondpdx](https://github.com/jbondpdx))
- (FM-4049) update to modulesync_configs [#585](https://github.com/puppetlabs/puppetlabs-apt/pull/585) ([DavidS](https://github.com/DavidS))
- Look for correct sources.list.d file for apt::ppa [#582](https://github.com/puppetlabs/puppetlabs-apt/pull/582) ([imphil](https://github.com/imphil))
- Add ubuntu 15.10 support [#578](https://github.com/puppetlabs/puppetlabs-apt/pull/578) ([pherjung](https://github.com/pherjung))
- fix whitespace in source.list [#577](https://github.com/puppetlabs/puppetlabs-apt/pull/577) ([amauf](https://github.com/amauf))
- Mergeback 2.2.x [#576](https://github.com/puppetlabs/puppetlabs-apt/pull/576) ([jonnytdevops](https://github.com/jonnytdevops))
- MODULES-2861: run stages limitation added to the documentation. [#575](https://github.com/puppetlabs/puppetlabs-apt/pull/575) ([ryayon](https://github.com/ryayon))

## [2.2.1](https://github.com/puppetlabs/puppetlabs-apt/tree/2.2.1) - 2015-12-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.2.0...2.2.1)

### Other

- Release 2.2.1 [#573](https://github.com/puppetlabs/puppetlabs-apt/pull/573) ([HelenCampbell](https://github.com/HelenCampbell))
- (MAINT) improve hiera description [#569](https://github.com/puppetlabs/puppetlabs-apt/pull/569) ([DavidS](https://github.com/DavidS))
- Mergeback 2.2.x to master [#567](https://github.com/puppetlabs/puppetlabs-apt/pull/567) ([bmjen](https://github.com/bmjen))

## [2.2.0](https://github.com/puppetlabs/puppetlabs-apt/tree/2.2.0) - 2015-09-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.1.1...2.2.0)

### Added

- Proxy ensure parameter. [#556](https://github.com/puppetlabs/puppetlabs-apt/pull/556) ([mike-callahan](https://github.com/mike-callahan))

### Other

- Release prep for 2.2.0 [#566](https://github.com/puppetlabs/puppetlabs-apt/pull/566) ([bmjen](https://github.com/bmjen))
- Add support for creating pins from main class [#564](https://github.com/puppetlabs/puppetlabs-apt/pull/564) ([rfdrake](https://github.com/rfdrake))
- Corrected regression with preference files name [#562](https://github.com/puppetlabs/puppetlabs-apt/pull/562) ([Vincent--](https://github.com/Vincent--))
- MODULES-2446 - Fix pinning for backports [#560](https://github.com/puppetlabs/puppetlabs-apt/pull/560) ([underscorgan](https://github.com/underscorgan))
- Fix path to 'preferences' and 'preferences.d'. [#557](https://github.com/puppetlabs/puppetlabs-apt/pull/557) ([fbarbeira](https://github.com/fbarbeira))
- 2.1.x mergeback [#553](https://github.com/puppetlabs/puppetlabs-apt/pull/553) ([bmjen](https://github.com/bmjen))
- Expose notify_update to apt::conf [#551](https://github.com/puppetlabs/puppetlabs-apt/pull/551) ([bdellegrazie](https://github.com/bdellegrazie))

## [2.1.1](https://github.com/puppetlabs/puppetlabs-apt/tree/2.1.1) - 2015-07-27

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.1.0...2.1.1)

### Other

- light edits to apt README [#552](https://github.com/puppetlabs/puppetlabs-apt/pull/552) ([jbondpdx](https://github.com/jbondpdx))
- 2.1.1 prep [#550](https://github.com/puppetlabs/puppetlabs-apt/pull/550) ([underscorgan](https://github.com/underscorgan))
- Merge master to 2.1.x [#549](https://github.com/puppetlabs/puppetlabs-apt/pull/549) ([underscorgan](https://github.com/underscorgan))
- Corrected documentation warning about `purge` parameters to fit v2.1.0 syntax [#548](https://github.com/puppetlabs/puppetlabs-apt/pull/548) ([leoarnold](https://github.com/leoarnold))
- Fix anchor issues [#547](https://github.com/puppetlabs/puppetlabs-apt/pull/547) ([underscorgan](https://github.com/underscorgan))
- Iterate through multiple keys [#546](https://github.com/puppetlabs/puppetlabs-apt/pull/546) ([igalic](https://github.com/igalic))
- Use Debian's new official mirrors redirector [#545](https://github.com/puppetlabs/puppetlabs-apt/pull/545) ([raoulbhatia](https://github.com/raoulbhatia))
- Revert "Fix use of $::apt::params::backports and $::apt::params::xfac… [#543](https://github.com/puppetlabs/puppetlabs-apt/pull/543) ([underscorgan](https://github.com/underscorgan))
- Fix use of $::apt::params::backports and $::apt::params::xfacts. [#542](https://github.com/puppetlabs/puppetlabs-apt/pull/542) ([Farzy](https://github.com/Farzy))
- Added additional header template for apt.conf style comments [#540](https://github.com/puppetlabs/puppetlabs-apt/pull/540) ([szynaka](https://github.com/szynaka))
- hashes are not supported in selectors [#539](https://github.com/puppetlabs/puppetlabs-apt/pull/539) ([underscorgan](https://github.com/underscorgan))
- typo [#538](https://github.com/puppetlabs/puppetlabs-apt/pull/538) ([underscorgan](https://github.com/underscorgan))
- Don't add puppetlabs sources for lucid [#537](https://github.com/puppetlabs/puppetlabs-apt/pull/537) ([underscorgan](https://github.com/underscorgan))
- Update update.pp [#536](https://github.com/puppetlabs/puppetlabs-apt/pull/536) ([Vincent--](https://github.com/Vincent--))
- Merge 2.1.x to master [#535](https://github.com/puppetlabs/puppetlabs-apt/pull/535) ([underscorgan](https://github.com/underscorgan))

## [2.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/2.1.0) - 2015-06-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.0.1...2.1.0)

### Other

- Apt::key doesn't have priority. [#534](https://github.com/puppetlabs/puppetlabs-apt/pull/534) ([underscorgan](https://github.com/underscorgan))
- DOCS: Edits to README.md [#533](https://github.com/puppetlabs/puppetlabs-apt/pull/533) ([jbondpdx](https://github.com/jbondpdx))
- Add helper to install puppet/pe/puppet-agent [#532](https://github.com/puppetlabs/puppetlabs-apt/pull/532) ([hunner](https://github.com/hunner))
- (maint) allow setting PUPPET_VERSION in acceptance [#531](https://github.com/puppetlabs/puppetlabs-apt/pull/531) ([justinstoller](https://github.com/justinstoller))
- 2.1.0 prep [#530](https://github.com/puppetlabs/puppetlabs-apt/pull/530) ([underscorgan](https://github.com/underscorgan))
- API compatibility between 1.8.x and 2.x for apt::source [#529](https://github.com/puppetlabs/puppetlabs-apt/pull/529) ([underscorgan](https://github.com/underscorgan))
- Make apt::key compatible with 1.8.x [#527](https://github.com/puppetlabs/puppetlabs-apt/pull/527) ([underscorgan](https://github.com/underscorgan))
- Fix travis.yml for puppet 4 [#526](https://github.com/puppetlabs/puppetlabs-apt/pull/526) ([hunner](https://github.com/hunner))
- Backwards compatibility with older versions of puppet [#525](https://github.com/puppetlabs/puppetlabs-apt/pull/525) ([ianmacl](https://github.com/ianmacl))
- Only use the strict variables workaround if using strict variables [#524](https://github.com/puppetlabs/puppetlabs-apt/pull/524) ([underscorgan](https://github.com/underscorgan))
- Modulesync updates [#523](https://github.com/puppetlabs/puppetlabs-apt/pull/523) ([underscorgan](https://github.com/underscorgan))
- Don't stub puppetversion [#521](https://github.com/puppetlabs/puppetlabs-apt/pull/521) ([hunner](https://github.com/hunner))
- test against puppet4 [#520](https://github.com/puppetlabs/puppetlabs-apt/pull/520) ([underscorgan](https://github.com/underscorgan))
- Test with strict variables on Puppet 4 too. [#519](https://github.com/puppetlabs/puppetlabs-apt/pull/519) ([daenney](https://github.com/daenney))
- Stubbing File.file? is hard [#518](https://github.com/puppetlabs/puppetlabs-apt/pull/518) ([underscorgan](https://github.com/underscorgan))
- Added new apt_reboot_required fact, updated readme, and added unit tests [#516](https://github.com/puppetlabs/puppetlabs-apt/pull/516) ([dlactin](https://github.com/dlactin))
- Merge 2.0.x to master [#515](https://github.com/puppetlabs/puppetlabs-apt/pull/515) ([underscorgan](https://github.com/underscorgan))
- Puppet 4 support [#508](https://github.com/puppetlabs/puppetlabs-apt/pull/508) ([daenney](https://github.com/daenney))
- Clear up lsb-release error [#505](https://github.com/puppetlabs/puppetlabs-apt/pull/505) ([daenney](https://github.com/daenney))

## [2.0.1](https://github.com/puppetlabs/puppetlabs-apt/tree/2.0.1) - 2015-04-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/2.0.0...2.0.1)

### Other

- Correct some README punctuation [#514](https://github.com/puppetlabs/puppetlabs-apt/pull/514) ([psoloway](https://github.com/psoloway))
- 2.0.1 prep [#513](https://github.com/puppetlabs/puppetlabs-apt/pull/513) ([underscorgan](https://github.com/underscorgan))
- Restore Puppet 3.4 and earlier compatibility [#511](https://github.com/puppetlabs/puppetlabs-apt/pull/511) ([underscorgan](https://github.com/underscorgan))
- Update README per DOC-1503 [#510](https://github.com/puppetlabs/puppetlabs-apt/pull/510) ([psoloway](https://github.com/psoloway))
- Merge fixes from 2.0.x [#507](https://github.com/puppetlabs/puppetlabs-apt/pull/507) ([underscorgan](https://github.com/underscorgan))
- Update tests to work with rspec-puppet 2.x [#504](https://github.com/puppetlabs/puppetlabs-apt/pull/504) ([underscorgan](https://github.com/underscorgan))
- Merge 2.0.x to master [#502](https://github.com/puppetlabs/puppetlabs-apt/pull/502) ([underscorgan](https://github.com/underscorgan))
- MODULES-1934: Iterate through multiple keys [#501](https://github.com/puppetlabs/puppetlabs-apt/pull/501) ([underscorgan](https://github.com/underscorgan))

## [2.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/2.0.0) - 2015-04-14

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.8.0...2.0.0)

### Other

- Fogot to remove the purge warning [#498](https://github.com/puppetlabs/puppetlabs-apt/pull/498) ([underscorgan](https://github.com/underscorgan))
- Don't purge by default. That seems unnecessarily destructive. [#497](https://github.com/puppetlabs/puppetlabs-apt/pull/497) ([underscorgan](https://github.com/underscorgan))
- apt::conf: Don't require content `ensure=>absent`. [#496](https://github.com/puppetlabs/puppetlabs-apt/pull/496) ([daenney](https://github.com/daenney))
- Try to make gepetto happy. [#495](https://github.com/puppetlabs/puppetlabs-apt/pull/495) ([underscorgan](https://github.com/underscorgan))
- Cleanup backports [#494](https://github.com/puppetlabs/puppetlabs-apt/pull/494) ([underscorgan](https://github.com/underscorgan))
- Remove default support for Linux Mint and Cumulus Networks [#493](https://github.com/puppetlabs/puppetlabs-apt/pull/493) ([underscorgan](https://github.com/underscorgan))
- more lint cleanup [#491](https://github.com/puppetlabs/puppetlabs-apt/pull/491) ([underscorgan](https://github.com/underscorgan))
- Lint cleanup [#490](https://github.com/puppetlabs/puppetlabs-apt/pull/490) ([underscorgan](https://github.com/underscorgan))
- 2.0.0 prep [#489](https://github.com/puppetlabs/puppetlabs-apt/pull/489) ([underscorgan](https://github.com/underscorgan))
- Merge master to next [#484](https://github.com/puppetlabs/puppetlabs-apt/pull/484) ([underscorgan](https://github.com/underscorgan))
- Add missing examples for 'removed' functionality [#483](https://github.com/puppetlabs/puppetlabs-apt/pull/483) ([underscorgan](https://github.com/underscorgan))
- Updated key fingerprints in README to match v1.8.0 requirements [#482](https://github.com/puppetlabs/puppetlabs-apt/pull/482) ([leoarnold](https://github.com/leoarnold))
- (BKR-147) add Gemfile setting for BEAKER_VERSION for puppet... [#480](https://github.com/puppetlabs/puppetlabs-apt/pull/480) ([anodelman](https://github.com/anodelman))
- (MODULES-1156, MODULES-769) Update anchors [#479](https://github.com/puppetlabs/puppetlabs-apt/pull/479) ([underscorgan](https://github.com/underscorgan))
- Extend docs for unattended_upgrades [#478](https://github.com/puppetlabs/puppetlabs-apt/pull/478) ([GhostLyrics](https://github.com/GhostLyrics))
- Doc updates [#477](https://github.com/puppetlabs/puppetlabs-apt/pull/477) ([underscorgan](https://github.com/underscorgan))
- Linux open-source builds are regularly maxed out. [#474](https://github.com/puppetlabs/puppetlabs-apt/pull/474) ([underscorgan](https://github.com/underscorgan))
- Remove `update['always'] = true` support [#473](https://github.com/puppetlabs/puppetlabs-apt/pull/473) ([underscorgan](https://github.com/underscorgan))
- Acceptance test fixes [#472](https://github.com/puppetlabs/puppetlabs-apt/pull/472) ([underscorgan](https://github.com/underscorgan))
- Merge 1.8.x to master [#471](https://github.com/puppetlabs/puppetlabs-apt/pull/471) ([underscorgan](https://github.com/underscorgan))

## [1.8.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.8.0) - 2015-03-17

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.7.0...1.8.0)

### Fixed

- Fix gpg key checking warings after f588f26 [#466](https://github.com/puppetlabs/puppetlabs-apt/pull/466) ([paroga](https://github.com/paroga))
- MODULES-1119 Fixed to now have username and passwords passed in again [#384](https://github.com/puppetlabs/puppetlabs-apt/pull/384) ([cyberious](https://github.com/cyberious))

### Other

- Update all the unit tests to look for full fingerprints [#469](https://github.com/puppetlabs/puppetlabs-apt/pull/469) ([underscorgan](https://github.com/underscorgan))
- 1.8.0 prep [#468](https://github.com/puppetlabs/puppetlabs-apt/pull/468) ([underscorgan](https://github.com/underscorgan))
- apt_key: fix parsing invalid dates when using GnuPG 2.x [#465](https://github.com/puppetlabs/puppetlabs-apt/pull/465) ([bootc](https://github.com/bootc))
- Update docs for unattended_upgrades [#464](https://github.com/puppetlabs/puppetlabs-apt/pull/464) ([underscorgan](https://github.com/underscorgan))
- Allow changing legacy_origin [#463](https://github.com/puppetlabs/puppetlabs-apt/pull/463) ([underscorgan](https://github.com/underscorgan))
- Make installation of software-properties optional [#462](https://github.com/puppetlabs/puppetlabs-apt/pull/462) ([underscorgan](https://github.com/underscorgan))
- Inheritance of apt::params means it can't be private [#461](https://github.com/puppetlabs/puppetlabs-apt/pull/461) ([underscorgan](https://github.com/underscorgan))
- initial commit for apt_key checking [#459](https://github.com/puppetlabs/puppetlabs-apt/pull/459) ([tphoney](https://github.com/tphoney))
- Cleaning 50unattended-upgrades.erb [#456](https://github.com/puppetlabs/puppetlabs-apt/pull/456) ([johanfleury](https://github.com/johanfleury))
- MODULES-1827 adding Cumulus Linux detection [#454](https://github.com/puppetlabs/puppetlabs-apt/pull/454) ([LeslieCarr](https://github.com/LeslieCarr))
- apt::source: Make location required. [#453](https://github.com/puppetlabs/puppetlabs-apt/pull/453) ([daenney](https://github.com/daenney))
- apt::source: Rename `trusted_source`. [#452](https://github.com/puppetlabs/puppetlabs-apt/pull/452) ([daenney](https://github.com/daenney))
- apt::source: Merge `include_*` options into hash. [#451](https://github.com/puppetlabs/puppetlabs-apt/pull/451) ([daenney](https://github.com/daenney))
- apt::params: Complete $xfacts. [#450](https://github.com/puppetlabs/puppetlabs-apt/pull/450) ([daenney](https://github.com/daenney))
- apt: Fix all strict variable cases. [#449](https://github.com/puppetlabs/puppetlabs-apt/pull/449) ([daenney](https://github.com/daenney))
- apt::setting: Remove file_perms. [#448](https://github.com/puppetlabs/puppetlabs-apt/pull/448) ([daenney](https://github.com/daenney))
- It's been a long time - how have you been [#447](https://github.com/puppetlabs/puppetlabs-apt/pull/447) ([daenney](https://github.com/daenney))
- apt: Add proxy support on the class. [#446](https://github.com/puppetlabs/puppetlabs-apt/pull/446) ([daenney](https://github.com/daenney))
- Make apt::setting notify Exec['apt_update'] by default [#445](https://github.com/puppetlabs/puppetlabs-apt/pull/445) ([underscorgan](https://github.com/underscorgan))
- apt::setting: Parse type and name from title. [#444](https://github.com/puppetlabs/puppetlabs-apt/pull/444) ([daenney](https://github.com/daenney))
- proxy_* params were removed from class apt [#443](https://github.com/puppetlabs/puppetlabs-apt/pull/443) ([underscorgan](https://github.com/underscorgan))
- Add base_name parameter to apt::setting [#442](https://github.com/puppetlabs/puppetlabs-apt/pull/442) ([underscorgan](https://github.com/underscorgan))
- Convert to use apt::setting instead of file resource [#441](https://github.com/puppetlabs/puppetlabs-apt/pull/441) ([underscorgan](https://github.com/underscorgan))
- Allow priorities to be zero-padded [#440](https://github.com/puppetlabs/puppetlabs-apt/pull/440) ([underscorgan](https://github.com/underscorgan))
- Convert specs to RSpec 3.1.7 syntax with Transpec [#439](https://github.com/puppetlabs/puppetlabs-apt/pull/439) ([underscorgan](https://github.com/underscorgan))
- apt::params: Make the class private. [#438](https://github.com/puppetlabs/puppetlabs-apt/pull/438) ([daenney](https://github.com/daenney))
- fix hiera example in documentation [#437](https://github.com/puppetlabs/puppetlabs-apt/pull/437) ([fraenki](https://github.com/fraenki))
- Type is a reserved word in puppet 4 [#435](https://github.com/puppetlabs/puppetlabs-apt/pull/435) ([underscorgan](https://github.com/underscorgan))
- PPA Cleanup, pt 1 [#433](https://github.com/puppetlabs/puppetlabs-apt/pull/433) ([underscorgan](https://github.com/underscorgan))
- Cleanup for `apt::source` [#432](https://github.com/puppetlabs/puppetlabs-apt/pull/432) ([underscorgan](https://github.com/underscorgan))
- Stop redeclaring variables from params [#431](https://github.com/puppetlabs/puppetlabs-apt/pull/431) ([underscorgan](https://github.com/underscorgan))
- Fix typo from #426 [#430](https://github.com/puppetlabs/puppetlabs-apt/pull/430) ([underscorgan](https://github.com/underscorgan))
- Remove 'include apt::update' [#429](https://github.com/puppetlabs/puppetlabs-apt/pull/429) ([underscorgan](https://github.com/underscorgan))
- apt: Add apt::setting defined type. [#428](https://github.com/puppetlabs/puppetlabs-apt/pull/428) ([daenney](https://github.com/daenney))
- RFC - Remove required packages [#427](https://github.com/puppetlabs/puppetlabs-apt/pull/427) ([underscorgan](https://github.com/underscorgan))
- apt::params: Add two missing entries, use them. [#426](https://github.com/puppetlabs/puppetlabs-apt/pull/426) ([daenney](https://github.com/daenney))
- Remove travis badge [#425](https://github.com/puppetlabs/puppetlabs-apt/pull/425) ([nibalizer](https://github.com/nibalizer))
- Hulk smash [#424](https://github.com/puppetlabs/puppetlabs-apt/pull/424) ([underscorgan](https://github.com/underscorgan))
- Ensure linter fails on lint warnings [#422](https://github.com/puppetlabs/puppetlabs-apt/pull/422) ([cmurphy](https://github.com/cmurphy))
- Update spec tests for future parser [#421](https://github.com/puppetlabs/puppetlabs-apt/pull/421) ([cmurphy](https://github.com/cmurphy))
- Pin rspec gems [#418](https://github.com/puppetlabs/puppetlabs-apt/pull/418) ([cmurphy](https://github.com/cmurphy))
- (doc) Add documentation for apt::key parameters and apt::pin parameters [#416](https://github.com/puppetlabs/puppetlabs-apt/pull/416) ([mkrakowitzer](https://github.com/mkrakowitzer))
- Documentation: Fix typo and syntax for example of apt::unattended_upgrad... [#414](https://github.com/puppetlabs/puppetlabs-apt/pull/414) ([phaf](https://github.com/phaf))
- Trusted will be a reserved word in Puppet 4 [#411](https://github.com/puppetlabs/puppetlabs-apt/pull/411) ([underscorgan](https://github.com/underscorgan))
- MODULES-1661 Fix to do delete with short key not long [#409](https://github.com/puppetlabs/puppetlabs-apt/pull/409) ([cyberious](https://github.com/cyberious))
- MODULES-1661 Fix issue with apt_key destroy, also added mutliple deletes [#408](https://github.com/puppetlabs/puppetlabs-apt/pull/408) ([cyberious](https://github.com/cyberious))
- Add support for parameter trusted MODULES-1658 [#407](https://github.com/puppetlabs/puppetlabs-apt/pull/407) ([mkrakowitzer](https://github.com/mkrakowitzer))
- Format documentation a little [#405](https://github.com/puppetlabs/puppetlabs-apt/pull/405) ([petems](https://github.com/petems))
- Allow full length GPG key fingerprints. [#404](https://github.com/puppetlabs/puppetlabs-apt/pull/404) ([WolverineFan](https://github.com/WolverineFan))
- Fix apt_has_updates fact not parsing apt-check output correctly [#403](https://github.com/puppetlabs/puppetlabs-apt/pull/403) ([WolverineFan](https://github.com/WolverineFan))
- Add IntelliJ files to the ignore list [#401](https://github.com/puppetlabs/puppetlabs-apt/pull/401) ([cmurphy](https://github.com/cmurphy))
- Allow ports that consist of 5 decimals [#400](https://github.com/puppetlabs/puppetlabs-apt/pull/400) ([voidus](https://github.com/voidus))
- Separate apt::pin for apt::backports to allow pin by release instead of ... [#398](https://github.com/puppetlabs/puppetlabs-apt/pull/398) ([riconnon](https://github.com/riconnon))
- Use puppet() instead of shell() to install module dependencies [#397](https://github.com/puppetlabs/puppetlabs-apt/pull/397) ([underscorgan](https://github.com/underscorgan))
- Add Ubuntu vivid (15.04) release [#395](https://github.com/puppetlabs/puppetlabs-apt/pull/395) ([udienz](https://github.com/udienz))
- (MODULES-1231) Fix apt::force locale issues [#394](https://github.com/puppetlabs/puppetlabs-apt/pull/394) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Update .travis.yml, Gemfile, Rakefile, and CONTRIBUTING.md [#391](https://github.com/puppetlabs/puppetlabs-apt/pull/391) ([cmurphy](https://github.com/cmurphy))
- Define travis matrix in .sync.yml [#390](https://github.com/puppetlabs/puppetlabs-apt/pull/390) ([cmurphy](https://github.com/cmurphy))
- (MODULES-1200) Fix inconsistent header across files [#389](https://github.com/puppetlabs/puppetlabs-apt/pull/389) ([stdietrich](https://github.com/stdietrich))
- Merge 1.6.x [#387](https://github.com/puppetlabs/puppetlabs-apt/pull/387) ([underscorgan](https://github.com/underscorgan))
- FM-1523: Added module summary to metadata.json [#386](https://github.com/puppetlabs/puppetlabs-apt/pull/386) ([jbondpdx](https://github.com/jbondpdx))
- Add utopic support [#385](https://github.com/puppetlabs/puppetlabs-apt/pull/385) ([pherjung](https://github.com/pherjung))
- merge 1.7.x into master [#380](https://github.com/puppetlabs/puppetlabs-apt/pull/380) ([underscorgan](https://github.com/underscorgan))
- Unattended upgrades oldstable for wheezy [#376](https://github.com/puppetlabs/puppetlabs-apt/pull/376) ([raoulbhatia](https://github.com/raoulbhatia))

## [1.7.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.7.0) - 2014-10-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.6.0...1.7.0)

### Other

- 1.7.0 prep [#378](https://github.com/puppetlabs/puppetlabs-apt/pull/378) ([underscorgan](https://github.com/underscorgan))
- Merge master back into 1.7.x [#377](https://github.com/puppetlabs/puppetlabs-apt/pull/377) ([underscorgan](https://github.com/underscorgan))
- Refactor facts to improve performance: [#375](https://github.com/puppetlabs/puppetlabs-apt/pull/375) ([raphink](https://github.com/raphink))
- Add support for RandomSleep to 10periodic [#374](https://github.com/puppetlabs/puppetlabs-apt/pull/374) ([bschlief](https://github.com/bschlief))
- Update pe compatibility [#373](https://github.com/puppetlabs/puppetlabs-apt/pull/373) ([underscorgan](https://github.com/underscorgan))
- DOC-249: Revised and updated apt readme [#372](https://github.com/puppetlabs/puppetlabs-apt/pull/372) ([jbondpdx](https://github.com/jbondpdx))
- add --force-yes so deb7 doesn't hang [#371](https://github.com/puppetlabs/puppetlabs-apt/pull/371) ([underscorgan](https://github.com/underscorgan))
- Missed one case for _kick_apt needed for strict variables [#369](https://github.com/puppetlabs/puppetlabs-apt/pull/369) ([underscorgan](https://github.com/underscorgan))
- Fix for future parser support [#368](https://github.com/puppetlabs/puppetlabs-apt/pull/368) ([underscorgan](https://github.com/underscorgan))
- apt-key doesn't add long keys in deb6 [#367](https://github.com/puppetlabs/puppetlabs-apt/pull/367) ([underscorgan](https://github.com/underscorgan))
- We aren't truncating in the type [#366](https://github.com/puppetlabs/puppetlabs-apt/pull/366) ([underscorgan](https://github.com/underscorgan))
- Don't truncate to short keys in the type [#365](https://github.com/puppetlabs/puppetlabs-apt/pull/365) ([underscorgan](https://github.com/underscorgan))
- apt::force: Added 2 parameters for automatic configuration file handling... [#363](https://github.com/puppetlabs/puppetlabs-apt/pull/363) ([martinseener](https://github.com/martinseener))
- MODULES-1259: added info on apt::update + edits to readme.md [#362](https://github.com/puppetlabs/puppetlabs-apt/pull/362) ([jbondpdx](https://github.com/jbondpdx))
- Merge 1.6.x into master [#360](https://github.com/puppetlabs/puppetlabs-apt/pull/360) ([underscorgan](https://github.com/underscorgan))
- (DOC-1230) Update all short key examples to use the long key id [#359](https://github.com/puppetlabs/puppetlabs-apt/pull/359) ([haus](https://github.com/haus))
- Fix issue with puppet_module_install, removed and using updated method f... [#358](https://github.com/puppetlabs/puppetlabs-apt/pull/358) ([cyberious](https://github.com/cyberious))
- Unpin puppet-lint [#357](https://github.com/puppetlabs/puppetlabs-apt/pull/357) ([cmurphy](https://github.com/cmurphy))
- Fix some Puppet Lint errors [#356](https://github.com/puppetlabs/puppetlabs-apt/pull/356) ([baurmatt](https://github.com/baurmatt))
- Only call install_* methods once [#352](https://github.com/puppetlabs/puppetlabs-apt/pull/352) ([underscorgan](https://github.com/underscorgan))
- Remove Puppet 2.7 from travis matrix [#350](https://github.com/puppetlabs/puppetlabs-apt/pull/350) ([cmurphy](https://github.com/cmurphy))
- Apt update tooling [#349](https://github.com/puppetlabs/puppetlabs-apt/pull/349) ([wolfspyre](https://github.com/wolfspyre))
- Remove stderr from stdout [#348](https://github.com/puppetlabs/puppetlabs-apt/pull/348) ([hunner](https://github.com/hunner))
- Builddep notifies apt-get update instead of requiring it [#326](https://github.com/puppetlabs/puppetlabs-apt/pull/326) ([dvcrn](https://github.com/dvcrn))

## [1.6.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.6.0) - 2014-08-13

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.5.2...1.6.0)

### Other

- Don't hardcode /etc/puppet as the puppetpath. [#347](https://github.com/puppetlabs/puppetlabs-apt/pull/347) ([underscorgan](https://github.com/underscorgan))
- Clean up test failures [#346](https://github.com/puppetlabs/puppetlabs-apt/pull/346) ([underscorgan](https://github.com/underscorgan))
- Merge 1.5.x changes [#345](https://github.com/puppetlabs/puppetlabs-apt/pull/345) ([underscorgan](https://github.com/underscorgan))
- Sometimes killing apt is too aggressive. [#344](https://github.com/puppetlabs/puppetlabs-apt/pull/344) ([underscorgan](https://github.com/underscorgan))
- Test fixes [#343](https://github.com/puppetlabs/puppetlabs-apt/pull/343) ([underscorgan](https://github.com/underscorgan))
- 1.5.3 prep [#341](https://github.com/puppetlabs/puppetlabs-apt/pull/341) ([underscorgan](https://github.com/underscorgan))
- 1.5.3 backports [#340](https://github.com/puppetlabs/puppetlabs-apt/pull/340) ([underscorgan](https://github.com/underscorgan))
- Test overhaul [#339](https://github.com/puppetlabs/puppetlabs-apt/pull/339) ([underscorgan](https://github.com/underscorgan))
- Debian seems to have hanging apt-get and/or dpkg processes, so kill [#336](https://github.com/puppetlabs/puppetlabs-apt/pull/336) ([underscorgan](https://github.com/underscorgan))
- Fix broken acceptance tests. [#335](https://github.com/puppetlabs/puppetlabs-apt/pull/335) ([underscorgan](https://github.com/underscorgan))
- 1.5.x merge [#334](https://github.com/puppetlabs/puppetlabs-apt/pull/334) ([underscorgan](https://github.com/underscorgan))
- Fix for debian/ubuntu hold and a way to add debian src only [#333](https://github.com/puppetlabs/puppetlabs-apt/pull/333) ([wilman0](https://github.com/wilman0))
- Fix inconsistent $proxy_host handling in apt and apt::ppa. [#330](https://github.com/puppetlabs/puppetlabs-apt/pull/330) ([dantman](https://github.com/dantman))
- Adds check to params.pp if lab-release is not installed [#329](https://github.com/puppetlabs/puppetlabs-apt/pull/329) ([spuder](https://github.com/spuder))

## [1.5.2](https://github.com/puppetlabs/puppetlabs-apt/tree/1.5.2) - 2014-07-21

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.5.1...1.5.2)

### Other

- Fix readme typo. [#332](https://github.com/puppetlabs/puppetlabs-apt/pull/332) ([big-samantha](https://github.com/big-samantha))
- Prepare a 1.5.2 release. [#331](https://github.com/puppetlabs/puppetlabs-apt/pull/331) ([apenney](https://github.com/apenney))

## [1.5.1](https://github.com/puppetlabs/puppetlabs-apt/tree/1.5.1) - 2014-07-10

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.5.0...1.5.1)

### Other

- 1.5.1 prep. [#328](https://github.com/puppetlabs/puppetlabs-apt/pull/328) ([underscorgan](https://github.com/underscorgan))
- MODULES-780 Don't blow up on unicode characters. [#327](https://github.com/puppetlabs/puppetlabs-apt/pull/327) ([adik](https://github.com/adik))
- Merge [#325](https://github.com/puppetlabs/puppetlabs-apt/pull/325) ([apenney](https://github.com/apenney))
- Add validate and lint tasks to travis script [#324](https://github.com/puppetlabs/puppetlabs-apt/pull/324) ([cmurphy](https://github.com/cmurphy))
- Update Gemfile for .travis.yml defaults [#323](https://github.com/puppetlabs/puppetlabs-apt/pull/323) ([cmurphy](https://github.com/cmurphy))
- Synchronize .travis.yml [#322](https://github.com/puppetlabs/puppetlabs-apt/pull/322) ([cmurphy](https://github.com/cmurphy))
- Enable auto-update for Debian squeeze-lts [#321](https://github.com/puppetlabs/puppetlabs-apt/pull/321) ([raoulbhatia](https://github.com/raoulbhatia))
- add facts showing available updates [#319](https://github.com/puppetlabs/puppetlabs-apt/pull/319) ([damoxc](https://github.com/damoxc))
- MODULES-780 Don't blow up on unicode characters. [#318](https://github.com/puppetlabs/puppetlabs-apt/pull/318) ([daenney](https://github.com/daenney))
- Start synchronizing module files [#316](https://github.com/puppetlabs/puppetlabs-apt/pull/316) ([cmurphy](https://github.com/cmurphy))
- Update apt::source example in README.md for #311 [#315](https://github.com/puppetlabs/puppetlabs-apt/pull/315) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Test osx graceful failure [#312](https://github.com/puppetlabs/puppetlabs-apt/pull/312) ([underscorgan](https://github.com/underscorgan))
- Allow for custom comment in sources.list file [#311](https://github.com/puppetlabs/puppetlabs-apt/pull/311) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Pin rspec [#309](https://github.com/puppetlabs/puppetlabs-apt/pull/309) ([apenney](https://github.com/apenney))
- Allow url for key server [#304](https://github.com/puppetlabs/puppetlabs-apt/pull/304) ([innyso](https://github.com/innyso))

## [1.5.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.5.0) - 2014-06-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.4.2...1.5.0)

### Other

- Remove claims of support. [#306](https://github.com/puppetlabs/puppetlabs-apt/pull/306) ([apenney](https://github.com/apenney))
- Fix the tests for Ubuntu 10.04. [#303](https://github.com/puppetlabs/puppetlabs-apt/pull/303) ([apenney](https://github.com/apenney))
- 1.5.0 prep [#301](https://github.com/puppetlabs/puppetlabs-apt/pull/301) ([underscorgan](https://github.com/underscorgan))
- Block this from running on unsupported platforms. [#300](https://github.com/puppetlabs/puppetlabs-apt/pull/300) ([apenney](https://github.com/apenney))
- 1.5.0 prep [#299](https://github.com/puppetlabs/puppetlabs-apt/pull/299) ([underscorgan](https://github.com/underscorgan))
- Fixed regex to follow APT requirements [#298](https://github.com/puppetlabs/puppetlabs-apt/pull/298) ([frconil](https://github.com/frconil))
- adding notice on top of sourceslist files [#297](https://github.com/puppetlabs/puppetlabs-apt/pull/297) ([frconil](https://github.com/frconil))
- 14x merge [#294](https://github.com/puppetlabs/puppetlabs-apt/pull/294) ([apenney](https://github.com/apenney))
- Drop testing on 3.3, add 3.5. [#292](https://github.com/puppetlabs/puppetlabs-apt/pull/292) ([daenney](https://github.com/daenney))
- Do not add bogus line to apt preference file on Debian Wheezy [#290](https://github.com/puppetlabs/puppetlabs-apt/pull/290) ([PaulusTM](https://github.com/PaulusTM))
- Implement fancy progress bars configuration. [#287](https://github.com/puppetlabs/puppetlabs-apt/pull/287) ([oc243](https://github.com/oc243))
- unattended_upgrades: Fix matching security archive [#286](https://github.com/puppetlabs/puppetlabs-apt/pull/286) ([apenney](https://github.com/apenney))
- Fix metadata.json file [#285](https://github.com/puppetlabs/puppetlabs-apt/pull/285) ([blkperl](https://github.com/blkperl))
- Change proxy's configuration file to be consistent with other config files in apt.conf.d [#283](https://github.com/puppetlabs/puppetlabs-apt/pull/283) ([johanfleury](https://github.com/johanfleury))
- Add security warning re: short keys [#282](https://github.com/puppetlabs/puppetlabs-apt/pull/282) ([lrnrthr](https://github.com/lrnrthr))
- unattended-upgrades: Fix origins for Squeeze. [#281](https://github.com/puppetlabs/puppetlabs-apt/pull/281) ([daenney](https://github.com/daenney))
- Fix pin comments [#280](https://github.com/puppetlabs/puppetlabs-apt/pull/280) ([daenney](https://github.com/daenney))
- Small patch to fix the spacing that makes lint fail. [#279](https://github.com/puppetlabs/puppetlabs-apt/pull/279) ([apenney](https://github.com/apenney))
- unattended_upgrades: Fix matching security archive [#278](https://github.com/puppetlabs/puppetlabs-apt/pull/278) ([daenney](https://github.com/daenney))
- Pin Rake to 10.1.1 in Gemfile [#276](https://github.com/puppetlabs/puppetlabs-apt/pull/276) ([blkperl](https://github.com/blkperl))
- backports: Allow setting a custom priority. [#275](https://github.com/puppetlabs/puppetlabs-apt/pull/275) ([daenney](https://github.com/daenney))
- Fix typo in ppa.pp [#274](https://github.com/puppetlabs/puppetlabs-apt/pull/274) ([fdrouet](https://github.com/fdrouet))
- Use File.expand_path with require. [#268](https://github.com/puppetlabs/puppetlabs-apt/pull/268) ([daenney](https://github.com/daenney))
- Fix typo [#267](https://github.com/puppetlabs/puppetlabs-apt/pull/267) ([apenney](https://github.com/apenney))
- Remove testing for Puppet 2.7 compatibility. [#263](https://github.com/puppetlabs/puppetlabs-apt/pull/263) ([daenney](https://github.com/daenney))
- Remove ancient Puppet versions from matrix. [#262](https://github.com/puppetlabs/puppetlabs-apt/pull/262) ([daenney](https://github.com/daenney))
- Remove autorelease [#261](https://github.com/puppetlabs/puppetlabs-apt/pull/261) ([hunner](https://github.com/hunner))
- pin: Replace invalid chars with _ in file names. [#260](https://github.com/puppetlabs/puppetlabs-apt/pull/260) ([daenney](https://github.com/daenney))
- apt::hold: Add a mechanism to hold a package. [#259](https://github.com/puppetlabs/puppetlabs-apt/pull/259) ([daenney](https://github.com/daenney))
- Add Ubuntu Trusty [#258](https://github.com/puppetlabs/puppetlabs-apt/pull/258) ([sodabrew](https://github.com/sodabrew))
- Add ability to specify hash of apt sources in hiera [#249](https://github.com/puppetlabs/puppetlabs-apt/pull/249) ([ghoneycutt](https://github.com/ghoneycutt))
- Fix fail message [#248](https://github.com/puppetlabs/puppetlabs-apt/pull/248) ([electrical](https://github.com/electrical))
- Rework apt::key to use apt_key. [#230](https://github.com/puppetlabs/puppetlabs-apt/pull/230) ([daenney](https://github.com/daenney))
- Make apt.conf.d/proxy world readable and add a newline [#209](https://github.com/puppetlabs/puppetlabs-apt/pull/209) ([pabl0](https://github.com/pabl0))
- Added retry to update operation [#193](https://github.com/puppetlabs/puppetlabs-apt/pull/193) ([ianunruh](https://github.com/ianunruh))

## [1.4.2](https://github.com/puppetlabs/puppetlabs-apt/tree/1.4.2) - 2014-03-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.4.1...1.4.2)

### Other

- Add back in missing fields to work around Puppet bug. [#257](https://github.com/puppetlabs/puppetlabs-apt/pull/257) ([apenney](https://github.com/apenney))
- Prepare supported module 1.4.2 [#256](https://github.com/puppetlabs/puppetlabs-apt/pull/256) ([apenney](https://github.com/apenney))
- Add "Release Notes/Known Bugs" to Changelog [#255](https://github.com/puppetlabs/puppetlabs-apt/pull/255) ([lrnrthr](https://github.com/lrnrthr))
- Prepare metadata for supported module release. [#253](https://github.com/puppetlabs/puppetlabs-apt/pull/253) ([apenney](https://github.com/apenney))
- Buncha picks [#246](https://github.com/puppetlabs/puppetlabs-apt/pull/246) ([hunner](https://github.com/hunner))
- Add lsbdistid facts where appropriate. [#244](https://github.com/puppetlabs/puppetlabs-apt/pull/244) ([apenney](https://github.com/apenney))
- Add non Debian os family unsupported test. [#242](https://github.com/puppetlabs/puppetlabs-apt/pull/242) ([hunner](https://github.com/hunner))
- Add non Debian os family unsupported test. [#241](https://github.com/puppetlabs/puppetlabs-apt/pull/241) ([hunner](https://github.com/hunner))
- apt: Allow managing of preferences file. [#240](https://github.com/puppetlabs/puppetlabs-apt/pull/240) ([daenney](https://github.com/daenney))
- Use smaller build-dep package [#239](https://github.com/puppetlabs/puppetlabs-apt/pull/239) ([hunner](https://github.com/hunner))
- Using rspec filters works better [#238](https://github.com/puppetlabs/puppetlabs-apt/pull/238) ([hunner](https://github.com/hunner))
- Port 8080 is a bad choice and bumps into puppetdb [#237](https://github.com/puppetlabs/puppetlabs-apt/pull/237) ([hunner](https://github.com/hunner))
- README and licensing fixes. [#235](https://github.com/puppetlabs/puppetlabs-apt/pull/235) ([daenney](https://github.com/daenney))
- Missed the - for -y, but also tests were missing lsbdistid [#234](https://github.com/puppetlabs/puppetlabs-apt/pull/234) ([hunner](https://github.com/hunner))
- Don't pass options to ppa on lucid [#231](https://github.com/puppetlabs/puppetlabs-apt/pull/231) ([hunner](https://github.com/hunner))
- apt_key: Support fetching keys over FTP. [#229](https://github.com/puppetlabs/puppetlabs-apt/pull/229) ([daenney](https://github.com/daenney))
- Make sure we handle PE properly. [#228](https://github.com/puppetlabs/puppetlabs-apt/pull/228) ([apenney](https://github.com/apenney))
- Force owner and mode on ppa files [#227](https://github.com/puppetlabs/puppetlabs-apt/pull/227) ([daniellawrence](https://github.com/daniellawrence))
- Update out of date Debian signing key for backports [#226](https://github.com/puppetlabs/puppetlabs-apt/pull/226) ([mark0n](https://github.com/mark0n))
- Port 8080 is a bad choice and bumps into puppetdb [#224](https://github.com/puppetlabs/puppetlabs-apt/pull/224) ([hunner](https://github.com/hunner))
- apt::pin: Allow for packages to be an array. [#223](https://github.com/puppetlabs/puppetlabs-apt/pull/223) ([daenney](https://github.com/daenney))
- Remove the quotes from the "origin" line. [#216](https://github.com/puppetlabs/puppetlabs-apt/pull/216) ([mcallaway](https://github.com/mcallaway))
- changed proxy_host default value from true to undef. fixes #211 [#215](https://github.com/puppetlabs/puppetlabs-apt/pull/215) ([lotherk](https://github.com/lotherk))
- apt_key type/provider [#212](https://github.com/puppetlabs/puppetlabs-apt/pull/212) ([daenney](https://github.com/daenney))

## [1.4.1](https://github.com/puppetlabs/puppetlabs-apt/tree/1.4.1) - 2014-02-14

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.4.0...1.4.1)

### Changed
- Handling of release parameter and apt provider in force manifest [#140](https://github.com/puppetlabs/puppetlabs-apt/pull/140) ([hunner](https://github.com/hunner))

### Other

- Use Puppet lint and ignore its warnings? [#220](https://github.com/puppetlabs/puppetlabs-apt/pull/220) ([justinstoller](https://github.com/justinstoller))
- allow specifying gem source via env var [#219](https://github.com/puppetlabs/puppetlabs-apt/pull/219) ([justinstoller](https://github.com/justinstoller))
- Enable fast finish in Travis [#214](https://github.com/puppetlabs/puppetlabs-apt/pull/214) ([ghoneycutt](https://github.com/ghoneycutt))
- Ensure apt::ppa fails on non-Ubuntu. [#208](https://github.com/puppetlabs/puppetlabs-apt/pull/208) ([apenney](https://github.com/apenney))
- Add additional acceptance testing. [#207](https://github.com/puppetlabs/puppetlabs-apt/pull/207) ([apenney](https://github.com/apenney))
- Convert existing tests over to beakr-rspec. [#206](https://github.com/puppetlabs/puppetlabs-apt/pull/206) ([apenney](https://github.com/apenney))
- fixed include, contained dash instead of underline. [#205](https://github.com/puppetlabs/puppetlabs-apt/pull/205) ([braddeicide](https://github.com/braddeicide))
- Apt::ppa should exec with root [#202](https://github.com/puppetlabs/puppetlabs-apt/pull/202) ([tsuharesu](https://github.com/tsuharesu))
- Update ppa.pp [#191](https://github.com/puppetlabs/puppetlabs-apt/pull/191) ([mnencia](https://github.com/mnencia))
- Use include instead of parameterized class when no params are given. [#187](https://github.com/puppetlabs/puppetlabs-apt/pull/187) ([ghoneycutt](https://github.com/ghoneycutt))
- Correct spelling typo in CHANGELOG [#186](https://github.com/puppetlabs/puppetlabs-apt/pull/186) ([ghoneycutt](https://github.com/ghoneycutt))
- Retry package installs [#185](https://github.com/puppetlabs/puppetlabs-apt/pull/185) ([dalen](https://github.com/dalen))
- add an 'ensure' parameter to apt::ppa [#184](https://github.com/puppetlabs/puppetlabs-apt/pull/184) ([rsrchboy](https://github.com/rsrchboy))
- apt::source templates/sources.list.erb generates invalid source line when architecture is provided. [#182](https://github.com/puppetlabs/puppetlabs-apt/pull/182) ([stefanvanwouw](https://github.com/stefanvanwouw))
- getparam() isn't available in all stdlib versions. [#178](https://github.com/puppetlabs/puppetlabs-apt/pull/178) ([apenney](https://github.com/apenney))
- Prepare 1.4.0 release. [#173](https://github.com/puppetlabs/puppetlabs-apt/pull/173) ([apenney](https://github.com/apenney))

## [1.4.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.4.0) - 2013-10-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.3.0...1.4.0)

### Other

- Fixed double-space typo [#175](https://github.com/puppetlabs/puppetlabs-apt/pull/175) ([lkoranda](https://github.com/lkoranda))
- Prepare 1.4.0 release. [#173](https://github.com/puppetlabs/puppetlabs-apt/pull/173) ([apenney](https://github.com/apenney))
- This work flips from onlyif to unless (mistakenly looked at the [#172](https://github.com/puppetlabs/puppetlabs-apt/pull/172) ([apenney](https://github.com/apenney))
- FM-103: Add metadata.json to all modules. [#170](https://github.com/puppetlabs/puppetlabs-apt/pull/170) ([apenney](https://github.com/apenney))
- This switches us to doing a `test -s` instead of checking for the [#169](https://github.com/puppetlabs/puppetlabs-apt/pull/169) ([apenney](https://github.com/apenney))
- Add initial rspec-system tests. [#168](https://github.com/puppetlabs/puppetlabs-apt/pull/168) ([apenney](https://github.com/apenney))
- add an updates_timeout option to apt::params (PR fix) [#167](https://github.com/puppetlabs/puppetlabs-apt/pull/167) ([madeddie](https://github.com/madeddie))
- Prepare 1.3.0 release. [#162](https://github.com/puppetlabs/puppetlabs-apt/pull/162) ([apenney](https://github.com/apenney))

## [1.3.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.3.0) - 2013-09-17

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.2.0...1.3.0)

### Other

- Fixed several lint warnings and errors [#156](https://github.com/puppetlabs/puppetlabs-apt/pull/156) ([rculbertson](https://github.com/rculbertson))
- Class for managing unattended-upgrades [#153](https://github.com/puppetlabs/puppetlabs-apt/pull/153) ([philipcohoe](https://github.com/philipcohoe))
- Update specs for #145 [#151](https://github.com/puppetlabs/puppetlabs-apt/pull/151) ([hunner](https://github.com/hunner))
- Use the geoDNS http.debian.net instead of the main debian ftp server [#150](https://github.com/puppetlabs/puppetlabs-apt/pull/150) ([bionix](https://github.com/bionix))
- Add wheezy backports support [#149](https://github.com/puppetlabs/puppetlabs-apt/pull/149) ([bionix](https://github.com/bionix))
- pass flags as string of single letter [#148](https://github.com/puppetlabs/puppetlabs-apt/pull/148) ([nagas](https://github.com/nagas))
- Fix: parametrize apt::ppa class for beign able to pass options to apt-add-repository command [#146](https://github.com/puppetlabs/puppetlabs-apt/pull/146) ([oleiade](https://github.com/oleiade))
- ppa: fix empty environment definition in exec ressource when no proxy [#145](https://github.com/puppetlabs/puppetlabs-apt/pull/145) ([PierreGambarotto](https://github.com/PierreGambarotto))
- Ppa proxy [#144](https://github.com/puppetlabs/puppetlabs-apt/pull/144) ([hunner](https://github.com/hunner))
- Release 1.2.0 [#141](https://github.com/puppetlabs/puppetlabs-apt/pull/141) ([hunner](https://github.com/hunner))

## [1.2.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.2.0) - 2013-07-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.1.1...1.2.0)

### Other

- Adding travis github automatic forge releases [#139](https://github.com/puppetlabs/puppetlabs-apt/pull/139) ([hunner](https://github.com/hunner))
- Release 111 [#138](https://github.com/puppetlabs/puppetlabs-apt/pull/138) ([hunner](https://github.com/hunner))
- replace aptitude with apt in apt::force [#134](https://github.com/puppetlabs/puppetlabs-apt/pull/134) ([spali](https://github.com/spali))
- apt::pin: handling all apt preferences properties [#131](https://github.com/puppetlabs/puppetlabs-apt/pull/131) ([mbornoz](https://github.com/mbornoz))
- Geppetto infrastructure [#124](https://github.com/puppetlabs/puppetlabs-apt/pull/124) ([DavidS](https://github.com/DavidS))
- Install required_packages before 'apt-get update' [#123](https://github.com/puppetlabs/puppetlabs-apt/pull/123) ([ctrlaltdel](https://github.com/ctrlaltdel))
- Add a $key_options parameter to apt::key. [#122](https://github.com/puppetlabs/puppetlabs-apt/pull/122) ([strangeman](https://github.com/strangeman))
- Release 1.1.1 [#121](https://github.com/puppetlabs/puppetlabs-apt/pull/121) ([kbarber](https://github.com/kbarber))
- Add optional architecture qualifier to apt-sources [#118](https://github.com/puppetlabs/puppetlabs-apt/pull/118) ([jopecko](https://github.com/jopecko))
- location change [#114](https://github.com/puppetlabs/puppetlabs-apt/pull/114) ([johnnyrun](https://github.com/johnnyrun))

## [1.1.1](https://github.com/puppetlabs/puppetlabs-apt/tree/1.1.1) - 2013-07-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.1.0...1.1.1)

### Other

- Release 111 [#138](https://github.com/puppetlabs/puppetlabs-apt/pull/138) ([hunner](https://github.com/hunner))
- Revert "Merge pull request #135 from CERIT-SC/master" [#137](https://github.com/puppetlabs/puppetlabs-apt/pull/137) ([hunner](https://github.com/hunner))
- Update travis and bundler [#136](https://github.com/puppetlabs/puppetlabs-apt/pull/136) ([hunner](https://github.com/hunner))
- Support APT pinning by codename [#135](https://github.com/puppetlabs/puppetlabs-apt/pull/135) ([vholer](https://github.com/vholer))
- trim keys to 8 chars for matching with apt-key list (fix for #100) [#133](https://github.com/puppetlabs/puppetlabs-apt/pull/133) ([benben](https://github.com/benben))
- add @ to variables in template [#120](https://github.com/puppetlabs/puppetlabs-apt/pull/120) ([peterhoeg](https://github.com/peterhoeg))
- Fix apt::release example in readme [#117](https://github.com/puppetlabs/puppetlabs-apt/pull/117) ([bkg](https://github.com/bkg))
- Restrict the versions and add 3.1 [#112](https://github.com/puppetlabs/puppetlabs-apt/pull/112) ([richardc](https://github.com/richardc))
- Updated content to conform to README best practices template [#109](https://github.com/puppetlabs/puppetlabs-apt/pull/109) ([lrnrthr](https://github.com/lrnrthr))
- Standardize travis.yml on pattern introduced in stdlib [#107](https://github.com/puppetlabs/puppetlabs-apt/pull/107) ([blkperl](https://github.com/blkperl))
- Build all branches on travis [#106](https://github.com/puppetlabs/puppetlabs-apt/pull/106) ([blkperl](https://github.com/blkperl))
- Update travis config file [#105](https://github.com/puppetlabs/puppetlabs-apt/pull/105) ([blkperl](https://github.com/blkperl))
- whitespace fixes [#102](https://github.com/puppetlabs/puppetlabs-apt/pull/102) ([mmoll](https://github.com/mmoll))
- minor correction to comment [#101](https://github.com/puppetlabs/puppetlabs-apt/pull/101) ([ChrisRut](https://github.com/ChrisRut))
- Release 1.1.0 (Ubuntu 12.10 support) [#97](https://github.com/puppetlabs/puppetlabs-apt/pull/97) ([ryanycoleman](https://github.com/ryanycoleman))

## [1.1.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.1.0) - 2012-12-02

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.0.1...1.1.0)

### Other

- Modified the PPA code for changes in Quantal [#96](https://github.com/puppetlabs/puppetlabs-apt/pull/96) ([jnicolson](https://github.com/jnicolson))
- Librarian bug [#94](https://github.com/puppetlabs/puppetlabs-apt/pull/94) ([ryanycoleman](https://github.com/ryanycoleman))

## [1.0.1](https://github.com/puppetlabs/puppetlabs-apt/tree/1.0.1) - 2012-10-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/1.0.0...1.0.1)

### Other

- Update Modulefile for 1.0.0 release [#93](https://github.com/puppetlabs/puppetlabs-apt/pull/93) ([ryanycoleman](https://github.com/ryanycoleman))

## [1.0.0](https://github.com/puppetlabs/puppetlabs-apt/tree/1.0.0) - 2012-10-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/0.0.4...1.0.0)

### Other

- Update readme.md - Syntax of apt class [#92](https://github.com/puppetlabs/puppetlabs-apt/pull/92) ([amenk](https://github.com/amenk))
- Improve documentation of the core apt class usage [#91](https://github.com/puppetlabs/puppetlabs-apt/pull/91) ([branan](https://github.com/branan))
- Add PL Repo source to README [#89](https://github.com/puppetlabs/puppetlabs-apt/pull/89) ([ryanycoleman](https://github.com/ryanycoleman))
- (#16076) Ability to fill in pin explanation [#85](https://github.com/puppetlabs/puppetlabs-apt/pull/85) ([dalen](https://github.com/dalen))
- (#16075) Allow pinning on version numbers [#84](https://github.com/puppetlabs/puppetlabs-apt/pull/84) ([dalen](https://github.com/dalen))
- (#16070) Allow optional order parameter to apt::pin [#83](https://github.com/puppetlabs/puppetlabs-apt/pull/83) ([dalen](https://github.com/dalen))
- Fix style errors [#82](https://github.com/puppetlabs/puppetlabs-apt/pull/82) ([dalen](https://github.com/dalen))
- Add a way to specify a timeout for the apt::force define. [#79](https://github.com/puppetlabs/puppetlabs-apt/pull/79) ([sathlan](https://github.com/sathlan))
- remove check, if $release is empty [#78](https://github.com/puppetlabs/puppetlabs-apt/pull/78) ([saz](https://github.com/saz))
- «main» repository is missing from ubuntu backports. [#77](https://github.com/puppetlabs/puppetlabs-apt/pull/77) ([jonhattan](https://github.com/jonhattan))
- Without puppetlabs/stdlib, you will get "err: Could not retrieve catalog... [#75](https://github.com/puppetlabs/puppetlabs-apt/pull/75) ([ytjohn](https://github.com/ytjohn))
- fix scoping of $lsbdistcodename in source.pp [#74](https://github.com/puppetlabs/puppetlabs-apt/pull/74) ([antonlindstrom](https://github.com/antonlindstrom))
- Add logoutput on_failure for all exec resources. [#73](https://github.com/puppetlabs/puppetlabs-apt/pull/73) ([nanliu](https://github.com/nanliu))
- Fix Modulefile for puppet-apt to puppetlabs-apt rename [#72](https://github.com/puppetlabs/puppetlabs-apt/pull/72) ([branan](https://github.com/branan))

## [0.0.4](https://github.com/puppetlabs/puppetlabs-apt/tree/0.0.4) - 2012-06-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/0.0.3...0.0.4)

### Other

- Fix Modulefile for puppet-apt to puppetlabs-apt rename [#72](https://github.com/puppetlabs/puppetlabs-apt/pull/72) ([branan](https://github.com/branan))
- Switch to the new puppetlabs_spec_helper gem [#70](https://github.com/puppetlabs/puppetlabs-apt/pull/70) ([branan](https://github.com/branan))
- Fix the spec test for apt::source [#69](https://github.com/puppetlabs/puppetlabs-apt/pull/69) ([branan](https://github.com/branan))
- Update Modulefile and CHANGELOG for 0.0.4 [#68](https://github.com/puppetlabs/puppetlabs-apt/pull/68) ([branan](https://github.com/branan))
- Remove a trailing comma to fix older puppets [#67](https://github.com/puppetlabs/puppetlabs-apt/pull/67) ([branan](https://github.com/branan))
- Fix spec tests [#65](https://github.com/puppetlabs/puppetlabs-apt/pull/65) ([branan](https://github.com/branan))
- Update Rakefile to my latest template version [#64](https://github.com/puppetlabs/puppetlabs-apt/pull/64) ([branan](https://github.com/branan))
- Pin source with originator. Useful for pinning Launchpad PPA [#63](https://github.com/puppetlabs/puppetlabs-apt/pull/63) ([rskvazh](https://github.com/rskvazh))
- Be a contributor [#62](https://github.com/puppetlabs/puppetlabs-apt/pull/62) ([zachfi](https://github.com/zachfi))
- Pin origin [#61](https://github.com/puppetlabs/puppetlabs-apt/pull/61) ([zachfi](https://github.com/zachfi))
- (#14657) Fix filename when there is a period in the PPA [#60](https://github.com/puppetlabs/puppetlabs-apt/pull/60) ([branan](https://github.com/branan))
- Spec improvements [#59](https://github.com/puppetlabs/puppetlabs-apt/pull/59) ([branan](https://github.com/branan))
- Fix dependency issues introduced with anchor. [#58](https://github.com/puppetlabs/puppetlabs-apt/pull/58) ([nanliu](https://github.com/nanliu))
- Fix style related issues in module. [#57](https://github.com/puppetlabs/puppetlabs-apt/pull/57) ([nanliu](https://github.com/nanliu))
- Add files for travis CI [#56](https://github.com/puppetlabs/puppetlabs-apt/pull/56) ([branan](https://github.com/branan))
- (#11966) apt module containment for apt_update. [#55](https://github.com/puppetlabs/puppetlabs-apt/pull/55) ([nanliu](https://github.com/nanliu))
- (#14221) update Modulefile for new release [#50](https://github.com/puppetlabs/puppetlabs-apt/pull/50) ([branan](https://github.com/branan))

## [0.0.3](https://github.com/puppetlabs/puppetlabs-apt/tree/0.0.3) - 2012-05-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/0.0.2...0.0.3)

### Other

- Move Package['python-software-properties'] to apt:ppa [#54](https://github.com/puppetlabs/puppetlabs-apt/pull/54) ([branan](https://github.com/branan))
- (#14321) apt::pin resource support release. [#53](https://github.com/puppetlabs/puppetlabs-apt/pull/53) ([nanliu](https://github.com/nanliu))
- (#14308) Add ensure=>absent for define resource. [#52](https://github.com/puppetlabs/puppetlabs-apt/pull/52) ([nanliu](https://github.com/nanliu))
- (#14299) Resolve Modulefile name mismatch. [#51](https://github.com/puppetlabs/puppetlabs-apt/pull/51) ([nanliu](https://github.com/nanliu))
- (#11966) Only invoke apt-get update once. [#49](https://github.com/puppetlabs/puppetlabs-apt/pull/49) ([nanliu](https://github.com/nanliu))
- Cleanup apt-module puppet-lint related issues. [#48](https://github.com/puppetlabs/puppetlabs-apt/pull/48) ([nanliu](https://github.com/nanliu))
- (#14138) Fix spec test for aptitude changes. [#47](https://github.com/puppetlabs/puppetlabs-apt/pull/47) ([nanliu](https://github.com/nanliu))
- (#14287) Fix apt::pin resource for rspec-puppet. [#46](https://github.com/puppetlabs/puppetlabs-apt/pull/46) ([nanliu](https://github.com/nanliu))
- (#14138) Modify apt::ppa's update-apt exec to use the ${apt::params::provider} parameter. [#44](https://github.com/puppetlabs/puppetlabs-apt/pull/44) ([relud](https://github.com/relud))
- Sync with pl ops [#42](https://github.com/puppetlabs/puppetlabs-apt/pull/42) ([ody](https://github.com/ody))
- Make sure we configure the proxy before doing apt-get update. [#41](https://github.com/puppetlabs/puppetlabs-apt/pull/41) ([tbroyer](https://github.com/tbroyer))
- Updated CHANGELOG and Modulefile for 0.0.2 [#39](https://github.com/puppetlabs/puppetlabs-apt/pull/39) ([ryanycoleman](https://github.com/ryanycoleman))

## [0.0.2](https://github.com/puppetlabs/puppetlabs-apt/tree/0.0.2) - 2012-03-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/0.0.1...0.0.2)

### Other

- Ticket/master/13289 Style violations & rspec cleanup [#37](https://github.com/puppetlabs/puppetlabs-apt/pull/37) ([kbarber](https://github.com/kbarber))
- Tickets/13261/improve smoke tests [#36](https://github.com/puppetlabs/puppetlabs-apt/pull/36) ([ryanycoleman](https://github.com/ryanycoleman))
- (#13125) Apt keys should be case insensitive [#34](https://github.com/puppetlabs/puppetlabs-apt/pull/34) ([blkperl](https://github.com/blkperl))
- Convert apt::key to use anchors [#32](https://github.com/puppetlabs/puppetlabs-apt/pull/32) ([reidmv](https://github.com/reidmv))

## [0.0.1](https://github.com/puppetlabs/puppetlabs-apt/tree/0.0.1) - 2012-03-07

[Full Changelog](https://github.com/puppetlabs/puppetlabs-apt/compare/f848bac6072f99e1cd60a0cc0b84e5679c598dab...0.0.1)

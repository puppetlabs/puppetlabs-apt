require 'spec_helper_acceptance'
require 'beaker/i18n_helper'

PUPPETLABS_GPG_KEY_LONG_ID     = '7F438280EF8D349F'.freeze
PUPPETLABS_LONG_FINGERPRINT    = '123456781274D2C8A956789A456789A456789A9A'.freeze

id_short_warning_pp = <<-MANIFEST
        apt_key { 'puppetlabs':
          id     => '#{PUPPETLABS_GPG_KEY_LONG_ID}',
          ensure => 'present',
          source => 'http://apt.puppetlabs.com/herpderp.gpg',
        }
  MANIFEST

id_doesnt_match_fingerprint_pp = <<-MANIFEST
        apt_key { '#{PUPPETLABS_LONG_FINGERPRINT}':
          ensure => 'present',
          content => '123456781274D2C8A956789A456789A456789A9B',
        }
  MANIFEST

location_not_specified_fail_pp = <<-MANIFEST
        apt::source { 'puppetlabs':
          ensure => 'present',
          repos    => 'main',
          key      => {
            id     => '6F6B15509CF8E59E6E469F327F438280EF8D349F',
            server => 'hkps.pool.sks-keyservers.net',
          },
        }
  MANIFEST

describe 'apt', if: (fact('osfamily') == 'Debian' || fact('osfamily') == 'RedHat') && (Gem::Version.new(puppet_version) >= Gem::Version.new('4.10.5')) do
  before :all do
    hosts.each do |host|
      on(host, "sed -i \"96i FastGettext.locale='ja'\" /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet.rb")
      change_locale_on(host, 'ja_JP.utf-8')
    end
  end

  describe 'i18n translations' do
    it 'warns with shortened id' do
      apply_manifest(id_short_warning_pp, catch_failures: true) do |r|
        expect(r.stderr).to match(%r{Ŧħḗ īḓ şħǿŭŀḓ ƀḗ ȧ ƒŭŀŀ ƒīƞɠḗřƥřīƞŧ})
      end
    end
    it 'fails with different id and fingerprint' do
      apply_manifest(id_doesnt_match_fingerprint_pp, expect_failures: true) do |r|
        expect(r.stderr).to match(%r{Ŧħḗ īḓ īƞ ẏǿŭř ḿȧƞīƒḗşŧ 123456781274D2C8A956789A456789A456789A9A})
      end
    end
    it 'fails with no location' do
      apply_manifest(location_not_specified_fail_pp, expect_failures: true) do |r|
        expect(r.stderr).to match(%r{ƈȧƞƞǿŧ ƈřḗȧŧḗ ȧ şǿŭřƈḗ ḗƞŧřẏ ẇīŧħǿŭŧ şƥḗƈīƒẏīƞɠ ȧ ŀǿƈȧŧīǿƞ})
      end
    end
  end

  after :all do
    hosts.each do |host|
      on(host, 'sed -i "96d" /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet.rb')
      change_locale_on(host, 'en_US')
    end
  end
end

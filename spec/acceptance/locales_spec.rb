require 'spec_helper_acceptance'
require 'beaker/i18n_helper'

PUPPETLABS_GPG_KEY_LONG_ID     = '7F438280EF8D349F'.freeze
SHOULD_NEVER_EXIST_ID          = 'EF8D349F'.freeze

socket_error_pp = <<-MANIFEST
        apt_key { 'puppetlabs':
          id     => '#{PUPPETLABS_GPG_KEY_LONG_ID}',
          ensure => 'present',
          source => 'http://apt.puppetlabss.com/herpderp.gpg',
        }
  MANIFEST

ftp_socket_error_pp = <<-MANIFEST
        apt_key { 'puppetlabs':
          id     => '#{PUPPETLABS_GPG_KEY_LONG_ID}',
          ensure => 'present',
          source => 'ftp://apt.puppetlabss.com/herpderp.gpg',
        }
  MANIFEST

https_socket_error_pp = <<-MANIFEST
        apt_key { 'puppetlabs':
          id     => '#{SHOULD_NEVER_EXIST_ID}',
          ensure => 'present',
          source => 'https://apt.puppetlabss.com/herpderp.gpg',
        }
  MANIFEST

describe 'apt_key', if: (fact('osfamily') == 'Debian' || fact('osfamily') == 'RedHat') && (Gem::Version.new(puppet_version) >= Gem::Version.new('4.10.5') &&
Gem::Version.new(puppet_version) < Gem::Version.new('5.2.0')) do
  before :all do
    hosts.each do |host|
      on(host, "sed -i \"96i FastGettext.locale='ja'\" /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet.rb")
      change_locale_on(host, 'ja_JP.utf-8')
    end
  end

  describe 'i18n translations' do
    it 'fails with a http socket error' do
      apply_manifest(socket_error_pp, expect_failures: true) do |r|
        expect(r.stderr).to match(%r{ƈǿŭŀḓ ƞǿŧ řḗşǿŀṽḗ})
      end
    end
    it 'fails with an ftp socket error' do
      apply_manifest(ftp_socket_error_pp, expect_failures: true) do |r|
        expect(r.stderr).to match(%r{ƈǿŭŀḓ ƞǿŧ řḗşǿŀṽḗ})
      end
    end
    it 'fails with an https socket error' do
      apply_manifest(https_socket_error_pp, expect_failures: true) do |r|
        expect(r.stderr).to match(%r{ƈǿŭŀḓ ƞǿŧ řḗşǿŀṽḗ})
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

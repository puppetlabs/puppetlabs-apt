# frozen_string_literal: true

require 'spec_helper_acceptance'

# apt-key was removed in apt 3 (Debian 13, Ubuntu 26.04). On those systems apt_key
# and apt::key must fail with directions to apt::keyring. Skipped where apt-key is
# available; apt_key_provider_spec.rb covers that case.
MISSING_KEY_FINGERPRINT = '6F6B15509CF8E59E6E469F327F438280EF8D349F'
MISSING_KEY_URL         = 'http://apt.puppetlabs.com/DEB-GPG-KEY-puppet'
MISSING_KEY_ERROR       = %r{apt-key command is not available.*apt::keyring}

describe 'apt_key without apt-key' do
  before(:each) do
    skip 'apt-key is available on this platform' if apt_key_available?
  end

  it 'has no apt-key command' do
    run_shell('command -v apt-key', expect_failures: true) do |r|
      expect(r.exit_code).not_to eq(0)
    end
  end

  it 'fails apt_key with directions to use apt::keyring' do
    pp = <<-MANIFEST
      apt_key { 'puppetlabs':
        ensure => present,
        id     => '#{MISSING_KEY_FINGERPRINT}',
        source => '#{MISSING_KEY_URL}',
      }
    MANIFEST
    apply_manifest(pp, expect_failures: true) do |r|
      expect(r.stderr).to match(MISSING_KEY_ERROR)
      expect(r.stderr).not_to match(%r{Could not find a suitable provider})
    end
  end

  it 'fails apt::key with directions to use apt::keyring' do
    pp = <<-MANIFEST
      class { 'apt': }
      apt::key { 'puppetlabs':
        id     => '#{MISSING_KEY_FINGERPRINT}',
        source => '#{MISSING_KEY_URL}',
      }
    MANIFEST
    apply_manifest(pp, expect_failures: true) do |r|
      expect(r.stderr).to match(MISSING_KEY_ERROR)
    end
  end

  it 'fails apt::source with a key id with directions to use apt::keyring' do
    pp = <<-MANIFEST
      class { 'apt': }
      apt::source { 'missing_key_test':
        location      => 'http://apt.puppetlabs.com',
        release       => 'stable',
        repos         => 'main',
        notify_update => false,
        key           => {
          'id'     => '#{MISSING_KEY_FINGERPRINT}',
          'source' => '#{MISSING_KEY_URL}',
        },
      }
    MANIFEST
    apply_manifest(pp, expect_failures: true) do |r|
      expect(r.stderr).to match(MISSING_KEY_ERROR)
    end
  end

  it 'works with apt::source and a keyring key name' do
    pp = <<-MANIFEST
      class { 'apt': }
      apt::source { 'missing_key_test':
        location      => 'http://apt.puppetlabs.com',
        release       => 'stable',
        repos         => 'main',
        notify_update => false,
        key           => {
          'name'   => 'missing_key_test.gpg',
          'source' => '#{MISSING_KEY_URL}',
        },
      }
    MANIFEST
    retry_on_error_matching do
      apply_manifest(pp, catch_failures: true)
    end
    apply_manifest(pp, catch_changes: true)
    run_shell('cat /etc/apt/sources.list.d/missing_key_test.list') do |r|
      expect(r.stdout).to match(%r{signed-by=/etc/apt/keyrings/missing_key_test\.gpg})
    end
  end

  after(:all) do
    run_shell('rm -f /etc/apt/sources.list.d/missing_key_test.list /etc/apt/keyrings/missing_key_test.gpg', expect_failures: true)
  end
end

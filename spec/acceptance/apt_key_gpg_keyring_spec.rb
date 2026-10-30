# frozen_string_literal: true

require 'spec_helper_acceptance'

# Covers the gpg_keyring provider of apt_key, which is used on systems without
# apt-key (apt 3: Debian 13, Ubuntu 26.04). Skipped where apt-key is available;
# apt_key_provider_spec.rb covers that case.
GPG_KEYRING_FINGERPRINT = '6F6B15509CF8E59E6E469F327F438280EF8D349F'
GPG_KEYRING_FILE        = "/etc/apt/keyrings/#{GPG_KEYRING_FINGERPRINT}.gpg".freeze
GPG_KEYRING_KEY_URL     = 'http://apt.puppetlabs.com/DEB-GPG-KEY-puppet'
GPG_KEYRING_CHECK       = "gpg --no-tty --show-keys --with-colons --fingerprint #{GPG_KEYRING_FILE} | grep #{GPG_KEYRING_FINGERPRINT}".freeze

def gpg_keyring_apply_twice(manifest_pp)
  retry_on_error_matching do
    apply_manifest(manifest_pp, catch_failures: true)
  end
  retry_on_error_matching do
    apply_manifest(manifest_pp, catch_changes: true)
  end
end

describe 'apt_key without apt-key' do
  before(:each) do
    skip 'apt-key is available on this platform' if apt_key_available?

    run_shell("rm -f #{GPG_KEYRING_FILE}")
  end

  after(:all) do
    run_shell("rm -f #{GPG_KEYRING_FILE}", expect_failures: true)
  end

  it 'has no apt-key command' do
    run_shell('command -v apt-key', expect_failures: true) do |r|
      expect(r.exit_code).not_to eq(0)
    end
  end

  context 'with source' do
    let(:source_pp) do
      <<-MANIFEST
        apt_key { 'puppetlabs':
          ensure => present,
          id     => '#{GPG_KEYRING_FINGERPRINT}',
          source => '#{GPG_KEYRING_KEY_URL}',
        }
      MANIFEST
    end

    it 'stores a de-armored keyring file idempotently' do
      gpg_keyring_apply_twice(source_pp)
      run_shell(GPG_KEYRING_CHECK)
      # de-armored keyrings are binary, not ASCII armor
      run_shell("grep -q 'BEGIN PGP' #{GPG_KEYRING_FILE}", expect_failures: true) do |r|
        expect(r.exit_code).not_to eq(0)
      end
    end

    it 'removes the keyring file with ensure => absent' do
      gpg_keyring_apply_twice(source_pp)
      absent_pp = source_pp.sub('present', 'absent')
      gpg_keyring_apply_twice(absent_pp)
      run_shell("test -e #{GPG_KEYRING_FILE}", expect_failures: true) do |r|
        expect(r.exit_code).not_to eq(0)
      end
    end
  end

  context 'with content' do
    it 'applies idempotently' do
      key = run_shell("curl -fsSL #{GPG_KEYRING_KEY_URL}").stdout.strip
      content_pp = <<-MANIFEST
        apt_key { 'puppetlabs':
          ensure  => present,
          id      => '#{GPG_KEYRING_FINGERPRINT}',
          content => "#{key}",
        }
      MANIFEST
      gpg_keyring_apply_twice(content_pp)
      run_shell(GPG_KEYRING_CHECK)
    end
  end

  context 'with a keyserver' do
    it 'applies idempotently' do
      keyserver_pp = <<-MANIFEST
        apt_key { 'puppetlabs':
          ensure => present,
          id     => '#{GPG_KEYRING_FINGERPRINT}',
          server => 'hkp://keyserver.ubuntu.com:80',
        }
      MANIFEST
      gpg_keyring_apply_twice(keyserver_pp)
      run_shell(GPG_KEYRING_CHECK)
    end
  end

  context 'with a bogus key' do
    it 'fails' do
      bogus_pp = <<-MANIFEST
        apt_key { 'puppetlabs':
          ensure  => present,
          id      => '#{GPG_KEYRING_FINGERPRINT}',
          content => 'bogus',
        }
      MANIFEST
      apply_manifest(bogus_pp, expect_failures: true)
      run_shell("test -e #{GPG_KEYRING_FILE}", expect_failures: true) do |r|
        expect(r.exit_code).not_to eq(0)
      end
    end
  end

  context 'with apt::source and a key id' do
    it 'writes signed-by pointing at the keyring file' do
      source_pp = <<-MANIFEST
        class { 'apt': }
        apt::source { 'gpg_keyring_test':
          location      => 'http://apt.puppetlabs.com',
          release       => 'stable',
          repos         => 'main',
          notify_update => false,
          key           => {
            'id'     => '#{GPG_KEYRING_FINGERPRINT}',
            'source' => '#{GPG_KEYRING_KEY_URL}',
          },
        }
      MANIFEST
      gpg_keyring_apply_twice(source_pp)
      run_shell(GPG_KEYRING_CHECK)
      run_shell('cat /etc/apt/sources.list.d/gpg_keyring_test.list') do |r|
        expect(r.stdout).to match(%r{signed-by=#{GPG_KEYRING_FILE}})
      end
    end

    after(:all) do
      run_shell('rm -f /etc/apt/sources.list.d/gpg_keyring_test.list', expect_failures: true)
    end
  end
end

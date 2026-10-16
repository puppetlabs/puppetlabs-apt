# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'apt::source' do
  context 'with a deb822 source, key and pin' do
    pp = <<-MANIFEST
      apt::source { 'puppetlabs':
        source_format => 'sources',
        location      => ['http://apt.puppetlabs.com'],
        repos         => ['puppet8'],
        key           => {
          'name'   => 'puppetlabs-keyring.gpg',
          'source' => 'https://apt.puppetlabs.com/keyring.gpg',
        },
        pin           => 600,
      }
    MANIFEST

    it 'applies idempotently' do
      retry_on_error_matching do
        idempotent_apply(pp)
      end
    end

    it 'uses the keyring for Signed-By' do
      run_shell('grep --quiet "^Signed-By: /etc/apt/keyrings/puppetlabs-keyring.gpg$" /etc/apt/sources.list.d/puppetlabs.sources')
    end

    it 'pins the source' do
      run_shell('apt-cache policy | grep --quiet "^ *600 http://apt.puppetlabs.com"')
    end
  end
end

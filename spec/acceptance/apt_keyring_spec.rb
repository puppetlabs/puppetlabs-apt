# frozen_string_literal: true

require 'spec_helper_acceptance'

PUPPETLABS_KEYRING_CHECK_COMMAND = 'gpg --import /etc/apt/keyrings/puppetlabs-keyring.gpg && gpg --list-keys | grep -F -A 1 \'pub   rsa4096 2019-04-08 [SC]\'' \
'| grep \'D6811ED3ADEEB8441AF5AA8F4528B6CD9E61EF26\''

describe 'apt::keyring' do
  context 'when using default values and source specified explicitly' do
    keyring_pp = <<-MANIFEST
      apt::keyring { 'puppetlabs-keyring.gpg':
        source => 'https://apt.puppetlabs.com/keyring.gpg',
      }
    MANIFEST

    it 'applies idempotently' do
      retry_on_error_matching do
        idempotent_apply(keyring_pp)
      end
    end

    it 'expects file content to be present and correct' do
      retry_on_error_matching do
        run_shell(PUPPETLABS_KEYRING_CHECK_COMMAND.to_s)
      end
    end
  end

  context 'when using refreshed GPG' do
    # add expired GPG key
    before(:each) do
      run_shell('curl https://apt.puppetlabs.com/DEB-GPG-KEY-puppet | gpg --dearmor >/etc/apt/keyrings/puppetlabs-keyring.gpg')
    end
    keyring_pp = <<-MANIFEST
      apt::keyring { 'puppetlabs-keyring.gpg':
        ensure => 'refreshed',
        source => 'https://apt.puppetlabs.com/keyring.gpg',
      }
    MANIFEST

    it 'updates GPG key' do
      retry_on_error_matching do
        idempotent_apply(keyring_pp)
        res = run_shell('gpg --show-keys --list-options show-sig-expire /etc/apt/keyrings/puppetlabs-keyring.gpg | grep expired')
        expect(res.stdout.strip).to eq('')
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper_acceptance'

PUPPETLABS_KEYRING_CHECK_COMMAND = 'gpg --import /etc/apt/keyrings/puppetlabs-keyring.gpg && gpg --list-keys | grep -F -A 1 \'pub   rsa4096 2019-04-08 [SC] [expires: 2025-04-06]\'' \
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

  context 'when de-armorized a key' do
    keyring_pp = <<-MANIFEST
      apt::keyring { 'gitlab-keyring.gpg':
        source  => 'https://packages.gitlab.com/gpg.key',
        dearmor => true,
      }
    MANIFEST

    it 'applies idempotently' do
      retry_on_error_matching do
        idempotent_apply(keyring_pp)
      end
    end

    it 'expects file content to be present and correct' do
      retry_on_error_matching do
        run_shell("grep '[^[:print:][:blank:]]' /etc/apt/keyrings/gitlab-keyring.gpg")
      end
    end
  end
end

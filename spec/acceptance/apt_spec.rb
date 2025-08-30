# frozen_string_literal: true

require 'spec_helper_acceptance'

everything_everything_pp = <<-MANIFEST
      $sources = {
        'puppetlabs' => {
          'ensure'   => present,
          'location' => 'http://apt.puppetlabs.com',
          'repos'    => 'main',
          'key'      => {
            'id'     => 'D6811ED3ADEEB8441AF5AA8F4528B6CD9E61EF26',
            'server' => 'keyserver.ubuntu.com',
          },
        },
      }
      class { 'apt':
        update => {
          'frequency' => 'always',
          'timeout'   => 400,
          'tries'     => 3,
        },
        purge => {
          'sources.list'   => true,
          'sources.list.d' => true,
          'preferences'    => true,
          'preferences.d'  => true,
          'apt.conf.d'     => true,
        },
        sources => $sources,
      }
MANIFEST

describe 'apt class' do
  context 'with test start reset' do
    it 'fixes the sources.list' do
      run_shell('cp /etc/apt/sources.list /tmp')
    end
  end

  context 'with all the things' do
    it 'works with no errors' do
      # Apply the manifest (Retry if timeout error is received from key pool)
      retry_on_error_matching do
        apply_manifest(everything_everything_pp, catch_failures: true)
      end
    end

    it 'stills work' do
      run_shell('apt-get update')
      run_shell('apt-get -y --allow-downgrades --allow-remove-essential --allow-change-held-packages upgrade')
    end
  end

  context 'with test end reset' do
    it 'fixes the sources.list' do
      run_shell('cp /tmp/sources.list /etc/apt')
    end
  end
end

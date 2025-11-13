# frozen_string_literal: true

require 'spec_helper'

describe 'apt::keyring' do
  let(:title) { 'puppetlabs-keyring.gpg' }
  let(:params) do
    {
      source: 'http://apt.puppetlabs.com/pubkey.gpg',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      context 'with default directory' do
        it {
          expect(subject).to contain_file('/etc/apt/keyrings/puppetlabs-keyring.gpg').with(
            ensure: 'file',
            mode: '0644',
            owner: 'root',
            group: 'root',
            source: 'http://apt.puppetlabs.com/pubkey.gpg',
          ).that_requires('File[keyrings]')
        }

        it {
          expect(subject).to contain_class('apt')
        }
      end

      context 'with custom directory' do
        let(:params) do
          {
            source: 'http://apt.puppetlabs.com/pubkey.gpg',
            dir: '/usr/share/keyrings',
          }
        end

        it {
          expect(subject).to contain_file('/usr/share/keyrings/puppetlabs-keyring.gpg').with(
            ensure: 'file',
            mode: '0644',
            owner: 'root',
            group: 'root',
            source: 'http://apt.puppetlabs.com/pubkey.gpg',
          ).that_requires('File[/usr/share/keyrings]')
        }

        it {
          expect(subject).to contain_file('/usr/share/keyrings').with(
            ensure: 'directory',
            mode: '0755',
          )
        }
      end

      context 'with content parameter' do
        let(:params) do
          {
            content: 'GPG KEY CONTENT',
          }
        end

        it {
          expect(subject).to contain_file('/etc/apt/keyrings/puppetlabs-keyring.gpg').with(
            ensure: 'file',
            content: 'GPG KEY CONTENT',
          )
        }
      end

      context 'with custom filename' do
        let(:params) do
          {
            source: 'http://apt.puppetlabs.com/pubkey.gpg',
            filename: 'custom-name.gpg',
          }
        end

        it {
          expect(subject).to contain_file('/etc/apt/keyrings/custom-name.gpg')
        }
      end

      context 'with ensure absent' do
        let(:params) do
          {
            ensure: 'absent',
          }
        end

        it {
          expect(subject).to contain_file('/etc/apt/keyrings/puppetlabs-keyring.gpg').with(
            ensure: 'absent',
          )
        }
      end

      context 'with both source and content' do
        let(:params) do
          {
            source: 'http://apt.puppetlabs.com/pubkey.gpg',
            content: 'GPG KEY CONTENT',
          }
        end

        it {
          expect(subject).to raise_error(%r{Parameters 'source' and 'content' are mutually exclusive})
        }
      end

      context 'without source or content and ensure present' do
        let(:params) do
          {
            ensure: 'present',
          }
        end

        it {
          expect(subject).to raise_error(%r{One of 'source' or 'content' parameters are required})
        }
      end
    end
  end
end

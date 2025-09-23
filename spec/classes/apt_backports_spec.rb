# frozen_string_literal: true

require 'spec_helper'

describe 'apt::backports', type: :class do
  let(:pre_condition) { 'include apt' }

  # Shared examples for Ubuntu tests
  shared_examples 'ubuntu backports' do |release_major, release_full, codename|
    context "with defaults on ubuntu #{release_major}" do
      let(:facts) do
        {
          os: {
            family: 'Debian',
            name: 'Ubuntu',
            release: {
              major: release_major,
              full: release_full
            },
            distro: {
              codename:,
              id: 'Ubuntu'
            }
          }
        }
      end

      it {
        expect(subject).to contain_apt__source('backports').with(
          location: 'http://archive.ubuntu.com/ubuntu',
          repos: 'main universe multiverse restricted',
          release: "#{codename}-backports",
          pin: {
            'priority' => 200,
            'release' => "#{codename}-backports"
          },
          keyring: '/usr/share/keyrings/ubuntu-archive-keyring.gpg',
        )
      }
    end

    context "with everything set on ubuntu #{release_major}" do
      let(:facts) do
        {
          os: {
            family: 'Debian',
            name: 'Ubuntu',
            release: {
              major: release_major,
              full: release_full
            },
            distro: {
              codename:,
              id: 'Ubuntu'
            }
          }
        }
      end
      let(:params) do
        {
          location: 'http://archive.ubuntu.com/ubuntu-test',
          release: 'vivid',
          repos: 'main',
          key: 'A1BD8E9D78F7FE5C3E65D8AF8B48AD6246925553',
          pin: '90'
        }
      end

      it {
        expect(subject).to contain_apt__source('backports').with(
          location: 'http://archive.ubuntu.com/ubuntu-test',
          key: 'A1BD8E9D78F7FE5C3E65D8AF8B48AD6246925553',
          repos: 'main',
          release: 'vivid',
          pin: { 'priority' => 90, 'release' => 'vivid' },
        )
      }
    end

    context "when set things with hashes on ubuntu #{release_major}" do
      let(:facts) do
        {
          os: {
            family: 'Debian',
            name: 'Ubuntu',
            release: {
              major: release_major,
              full: release_full
            },
            distro: {
              codename:,
              id: 'Ubuntu'
            }
          }
        }
      end
      let(:params) do
        {
          key: {
            'id' => 'A1BD8E9D78F7FE5C3E65D8AF8B48AD6246925553'
          },
          pin: {
            'priority' => '90'
          }
        }
      end

      it {
        expect(subject).to contain_apt__source('backports').with(
          key: { 'id' => 'A1BD8E9D78F7FE5C3E65D8AF8B48AD6246925553' },
          pin: { 'priority' => '90' },
        )
      }
    end
  end

  # Shared examples for validation tests
  shared_examples 'validation tests' do |release_major, release_full, codename|
    describe "validation on ubuntu #{release_major}" do
      let(:facts) do
        {
          os: {
            family: 'Debian',
            name: 'Ubuntu',
            release: {
              major: release_major,
              full: release_full
            },
            distro: {
              codename:,
              id: 'Ubuntu'
            }
          }
        }
      end

      context 'with invalid location' do
        let(:params) do
          {
            location: true
          }
        end

        it do
          expect(subject).to raise_error(Puppet::Error, %r{expects a})
        end
      end

      context 'with invalid release' do
        let(:params) do
          {
            release: true
          }
        end

        it do
          expect(subject).to raise_error(Puppet::Error, %r{expects a})
        end
      end

      context 'with invalid repos' do
        let(:params) do
          {
            repos: true
          }
        end

        it do
          expect(subject).to raise_error(Puppet::Error, %r{expects a})
        end
      end

      context 'with invalid key' do
        let(:params) do
          {
            key: true
          }
        end

        it do
          expect(subject).to raise_error(Puppet::Error, %r{expects a})
        end
      end

      context 'with invalid pin' do
        let(:params) do
          {
            pin: true
          }
        end

        it do
          expect(subject).to raise_error(Puppet::Error, %r{expects a})
        end
      end
    end
  end

  describe 'debian/ubuntu tests' do
    context 'with defaults on debian' do
      let(:facts) do
        {
          os: {
            family: 'Debian',
            name: 'Debian',
            release: {
              full: '12.5',
              major: '12',
              minor: '5'
            },
            distro: {
              codename: 'bookworm',
              id: 'Debian'
            }
          }
        }
      end

      it {
        expect(subject).to contain_apt__source('backports').with(
          location: 'http://deb.debian.org/debian',
          repos: 'main contrib non-free non-free-firmware',
          release: 'bookworm-backports',
          pin: {
            'priority' => 200,
            'codename' => 'bookworm-backports'
          },
          keyring: '/usr/share/keyrings/debian-archive-keyring.gpg',
        )
      }
    end

    # Include shared examples for Ubuntu versions
    include_examples 'ubuntu backports', '22.04', '22.04', 'jammy'
    include_examples 'ubuntu backports', '24.04', '24.04', 'noble'
  end

  # Include shared validation examples for Ubuntu versions
  include_examples 'validation tests', '22.04', '22.04', 'jammy'
  include_examples 'validation tests', '24.04', '24.04', 'noble'
end

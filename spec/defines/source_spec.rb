# frozen_string_literal: true

require 'spec_helper'

describe 'apt::source' do
  let(:id) { '6F6B15509CF8E59E6E469F327F438280EF8D349F' }
  let(:title) { 'my_source' }
  let(:pre_condition) { 'class { "apt": }' }
  let :facts do
    {
      os: {
        family: 'Debian',
        name: 'Debian',
        release: {
          major: '9',
          full: '9.0'
        },
        distro: {
          codename: 'stretch',
          id: 'Debian'
        }
      }
    }
  end

  context 'with defaults' do
    context 'without location' do
      it do
        expect(subject).to raise_error(Puppet::Error, %r{source entry without specifying a location})
      end
    end

    context 'with location' do
      let(:params) { { location: 'hello.there' } }

      it {
        expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').without_content(%r{# my_source\ndeb-src hello.there wheezy main\n})
        expect(subject).not_to contain_package('apt-transport-https')
      }
    end
  end

  describe 'no defaults' do
    context 'with complex pin' do
      let :params do
        {
          location: 'hello.there',
          pin: { 'release' => 'wishwash',
                 'explanation' => 'wishwash',
                 'priority' => 1001 }
        }
      end

      it {
        expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').with_content(%r{hello.there stretch main\n})
      }

      it { is_expected.to contain_file('/etc/apt/sources.list.d/my_source.list').that_notifies('Class[Apt::Update]') }

      it {
        expect(subject).to contain_apt__pin('my_source').that_comes_before('Apt::Setting[list-my_source]').with(ensure: 'present',
                                                                                                                priority: 1001,
                                                                                                                explanation: 'wishwash',
                                                                                                                release: 'wishwash')
      }
    end

    context 'with simple key' do
      let :params do
        {
          comment: 'foo',
          location: 'http://debian.mirror.iweb.ca/debian/',
          release: 'sid',
          repos: 'testing',
          key: id,
          pin: '10',
          architecture: 'x86_64',
          allow_unsigned: true
        }
      end

      it {
        expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').with_content(%r{# foo\ndeb \[arch=x86_64 trusted=yes\] http://debian.mirror.iweb.ca/debian/ sid testing\n})
                                                                 .without_content(%r{deb-src})
      }

      it {
        expect(subject).to contain_apt__pin('my_source').that_comes_before('Apt::Setting[list-my_source]').with(ensure: 'present',
                                                                                                                priority: '10',
                                                                                                                origin: 'debian.mirror.iweb.ca')
      }

      it {
        expect(subject).to contain_apt__key("Add key: #{id} from Apt::Source my_source").that_comes_before('Apt::Setting[list-my_source]').with(ensure: 'present',
                                                                                                                                                id: id)
      }
    end

    context 'with complex key' do
      let :params do
        {
          comment: 'foo',
          location: 'http://debian.mirror.iweb.ca/debian/',
          release: 'sid',
          repos: 'testing',
          key: {
            'ensure' => 'refreshed',
            'id' => id,
            'server' => 'pgp.mit.edu',
            'content' => 'GPG key content',
            'source' => 'http://apt.puppetlabs.com/pubkey.gpg',
            'weak_ssl' => true
          },
          pin: '10',
          architecture: 'x86_64',
          allow_unsigned: true
        }
      end

      it {
        expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').with_content(%r{# foo\ndeb \[arch=x86_64 trusted=yes\] http://debian.mirror.iweb.ca/debian/ sid testing\n})
                                                                 .without_content(%r{deb-src})
      }

      it {
        expect(subject).to contain_apt__pin('my_source').that_comes_before('Apt::Setting[list-my_source]').with(ensure: 'present',
                                                                                                                priority: '10',
                                                                                                                origin: 'debian.mirror.iweb.ca')
      }

      it {
        expect(subject).to contain_apt__key("Add key: #{id} from Apt::Source my_source").that_comes_before('Apt::Setting[list-my_source]').with(ensure: 'refreshed',
                                                                                                                                                id: id,
                                                                                                                                                server: 'pgp.mit.edu',
                                                                                                                                                content: 'GPG key content',
                                                                                                                                                source: 'http://apt.puppetlabs.com/pubkey.gpg',
                                                                                                                                                weak_ssl: true)
      }
    end
  end

  context 'with allow_insecure true' do
    let :params do
      {
        location: 'hello.there',
        allow_insecure: true
      }
    end

    it {
      expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').with_content(%r{# my_source\ndeb \[allow-insecure=yes\] hello.there stretch main\n})
    }
  end

  context 'with allow_unsigned true' do
    let :params do
      {
        location: 'hello.there',
        allow_unsigned: true
      }
    end

    it {
      expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').with_content(%r{# my_source\ndeb \[trusted=yes\] hello.there stretch main\n})
    }
  end

  context 'with check_valid_until false' do
    let :params do
      {
        location: 'hello.there',
        check_valid_until: false
      }
    end

    it {
      expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').with_content(%r{# my_source\ndeb \[check-valid-until=false\] hello.there stretch main\n})
    }
  end

  context 'with check_valid_until true' do
    let :params do
      {
        location: 'hello.there',
        check_valid_until: true
      }
    end

    it {
      expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').with_content(%r{# my_source\ndeb hello.there stretch main\n})
    }
  end

  context 'with keyring set' do
    let :params do
      {
        location: 'hello.there',
        keyring: '/usr/share/keyrings/foo-archive-keyring.gpg'
      }
    end

    it {
      expect(subject).to contain_apt__setting('list-my_source')
        .with(ensure: 'present')
        .with_content(%r{# my_source\ndeb \[signed-by=/usr/share/keyrings/foo-archive-keyring.gpg\] hello.there stretch main\n})
    }
  end

  context 'with keyring, architecture and allow_unsigned set' do
    let :params do
      {
        location: 'hello.there',
        architecture: 'amd64',
        allow_unsigned: true,
        keyring: '/usr/share/keyrings/foo-archive-keyring.gpg'
      }
    end

    it {
      expect(subject).to contain_apt__setting('list-my_source')
        .with(ensure: 'present')
        .with_content(%r{# my_source\ndeb \[arch=amd64 trusted=yes signed-by=/usr/share/keyrings/foo-archive-keyring.gpg\] hello.there stretch main\n})
    }
  end

  context 'with a https location, install apt-transport-https' do
    let :params do
      {
        location: 'HTTPS://foo.bar',
        allow_unsigned: false
      }
    end

    it {
      expect(subject).to contain_package('apt-transport-https')
    }
  end

  context 'with a https location and custom release, install apt-transport-https' do
    let :facts do
      {
        os: {
          family: 'Debian',
          name: 'Debian',
          release: {
            major: '9',
            full: '9.0'
          },
          distro: {
            codename: 'stretch',
            id: 'Debian'
          }
        },
        puppetversion: Puppet.version
      }
    end
    let :params do
      {
        location: 'HTTPS://foo.bar',
        allow_unsigned: false,
        release: 'customrelease'
      }
    end

    it {
      expect(subject).to contain_package('apt-transport-https')
    }
  end

  context 'with a https location, do not install apt-transport-https on oses not in list eg buster' do
    let :facts do
      {
        os: {
          family: 'Debian',
          name: 'Debian',
          release: {
            major: '10',
            full: '10.0'
          },
          distro: {
            codename: 'buster',
            id: 'Debian'
          }
        }
      }
    end
    let :params do
      {
        location: 'https://foo.bar',
        allow_unsigned: false
      }
    end

    it {
      expect(subject).not_to contain_package('apt-transport-https')
    }
  end

  context 'with architecture equals x86_64' do
    let :facts do
      {
        os: {
          family: 'Debian',
          name: 'Debian',
          release: {
            major: '7',
            full: '7.0'
          },
          distro: {
            codename: 'wheezy',
            id: 'Debian'
          }
        }
      }
    end
    let :params do
      {
        location: 'hello.there',
        include: { 'deb' => false, 'src' => true },
        architecture: 'x86_64'
      }
    end

    it {
      expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').with_content(%r{# my_source\ndeb-src \[arch=x86_64\] hello.there wheezy main\n})
    }
  end

  context 'with architecture fact and unset architecture parameter' do
    let :facts do
      super().merge(architecture: 'amd64')
    end
    let :params do
      {
        location: 'hello.there',
        include: { 'deb' => false, 'src' => true }
      }
    end

    it {
      expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').with_content(%r{# my_source\ndeb-src hello.there stretch main\n})
    }
  end

  context 'with include_src => true' do
    let :params do
      {
        location: 'hello.there',
        include: { 'src' => true }
      }
    end

    it {
      expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').with_content(%r{# my_source\ndeb hello.there stretch main\ndeb-src hello.there stretch main\n})
    }
  end

  context 'with include deb => false' do
    let :params do
      {
        include: { 'deb' => false },
        location: 'hello.there'
      }
    end

    it {
      expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').without_content(%r{deb-src hello.there wheezy main\n})
    }

    it { is_expected.to contain_apt__setting('list-my_source').without_content(%r{deb hello.there wheezy main\n}) }
  end

  context 'with include src => true and include deb => false' do
    let :params do
      {
        include: { 'deb' => false, 'src' => true },
        location: 'hello.there'
      }
    end

    it {
      expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'present').with_content(%r{deb-src hello.there stretch main\n})
    }

    it { is_expected.to contain_apt__setting('list-my_source').without_content(%r{deb hello.there stretch main\n}) }
  end

  context 'with ensure => absent' do
    let :params do
      {
        ensure: 'absent'
      }
    end

    it {
      expect(subject).to contain_apt__setting('list-my_source').with(ensure: 'absent')
    }
  end

  describe 'validation' do
    context 'with no release' do
      let :facts do
        {
          os: {
            family: 'Debian',
            name: 'Debian',
            release: {
              major: '8',
              full: '8.0'
            },
            distro: {
              id: 'Debian'
            }
          }
        }
      end
      let(:params) { { location: 'hello.there' } }

      it do
        expect(subject).to raise_error(Puppet::Error, %r{os.distro.codename fact not available: release parameter required})
      end
    end

    context 'with release is empty string' do
      let(:params) { { location: 'hello.there', release: '' } }

      it { is_expected.to contain_apt__setting('list-my_source').with_content(%r{hello\.there  main}) }
    end

    context 'with invalid pin' do
      let :params do
        {
          location: 'hello.there',
          pin: true
        }
      end

      it do
        expect(subject).to raise_error(Puppet::Error, %r{expects a value})
      end
    end

    context 'with notify_update = undef (default)' do
      let :params do
        {
          location: 'hello.there'
        }
      end

      it { is_expected.to contain_apt__setting("list-#{title}").with_notify_update(true) }
    end

    context 'with notify_update = true' do
      let :params do
        {
          location: 'hello.there',
          notify_update: true
        }
      end

      it { is_expected.to contain_apt__setting("list-#{title}").with_notify_update(true) }
    end

    context 'with notify_update = false' do
      let :params do
        {
          location: 'hello.there',
          notify_update: false
        }
      end

      it { is_expected.to contain_apt__setting("list-#{title}").with_notify_update(false) }
    end
  end
end

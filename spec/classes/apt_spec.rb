# frozen_string_literal: true

require 'spec_helper'

sources_list = {  ensure: 'file',
                  path: '/etc/apt/sources.list',
                  owner: 'root',
                  group: 'root',
                  notify: 'Class[Apt::Update]' }

sources_list_d = { ensure: 'directory',
                   path: '/etc/apt/sources.list.d',
                   owner: 'root',
                   group: 'root',
                   purge: false,
                   recurse: false,
                   notify: 'Class[Apt::Update]' }

preferences = { ensure: 'file',
                path: '/etc/apt/preferences',
                owner: 'root',
                group: 'root',
                notify: 'Class[Apt::Update]' }

preferences_d = { ensure: 'directory',
                  path: '/etc/apt/preferences.d',
                  owner: 'root',
                  group: 'root',
                  purge: false,
                  recurse: false,
                  notify: 'Class[Apt::Update]' }

apt_conf_d = {    ensure: 'directory',
                  path: '/etc/apt/apt.conf.d',
                  owner: 'root',
                  group: 'root',
                  purge: false,
                  recurse: false,
                  notify: 'Class[Apt::Update]' }

describe 'apt' do
  let(:facts) do
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
    it {
      expect(subject).to contain_file('sources.list').that_notifies('Class[Apt::Update]').only_with(sources_list)
    }

    it {
      expect(subject).to contain_file('sources.list.d').that_notifies('Class[Apt::Update]').only_with(sources_list_d)
    }

    it {
      expect(subject).to contain_file('preferences').that_notifies('Class[Apt::Update]').only_with(preferences)
    }

    it {
      expect(subject).to contain_file('preferences.d').that_notifies('Class[Apt::Update]').only_with(preferences_d)
    }

    it {
      expect(subject).to contain_file('apt.conf.d').that_notifies('Class[Apt::Update]').only_with(apt_conf_d)
    }

    it { is_expected.to contain_file('/etc/apt/auth.conf').with_ensure('absent') }

    it 'lays down /etc/apt/apt.conf.d/15update-stamp' do
      expect(subject).to contain_file('/etc/apt/apt.conf.d/15update-stamp').with(group: 'root',
                                                                                 owner: 'root').with_content(
                                                                                   %r{APT::Update::Post-Invoke-Success {"touch /var/lib/apt/periodic/update-success-stamp 2>/dev/null || true";};},
                                                                                 )
    end

    it {
      expect(subject).to contain_exec('apt_update').with(refreshonly: 'true')
    }

    it { is_expected.not_to contain_apt__setting('conf-proxy') }
  end

  describe 'proxy=' do
    context 'when host=localhost' do
      let(:params) { { proxy: { 'host' => 'localhost' } } }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(priority: '01').with_content(
          %r{Acquire::http::proxy "http://localhost:8080/";},
        ).without_content(
          %r{Acquire::https::proxy },
        )
      }
    end

    context 'when host=localhost and per-host[proxyscope]=proxyhost' do
      let(:params) { { proxy: { 'host' => 'localhost', 'perhost' => [{ 'scope' => 'proxyscope', 'host' => 'proxyhost' }] } } }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(priority: '01').with_content(
          %r{Acquire::http::proxy::proxyscope "http://proxyhost:8080/";},
        )
      }
    end

    context 'when host=localhost and per-host[proxyscope]=proxyhost:8081' do
      let(:params) { { proxy: { 'host' => 'localhost', 'perhost' => [{ 'scope' => 'proxyscope', 'host' => 'proxyhost', 'port' => 8081 }] } } }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(priority: '01').with_content(
          %r{Acquire::http::proxy::proxyscope "http://proxyhost:8081/";},
        )
      }
    end

    context 'when host=localhost and per-host[proxyscope]=[https]proxyhost' do
      let(:params) { { proxy: { 'host' => 'localhost', 'perhost' => [{ 'scope' => 'proxyscope', 'host' => 'proxyhost', 'https' => true }] } } }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(priority: '01').with_content(
          %r{Acquire::https::proxy::proxyscope "https://proxyhost:8080/";},
        )
      }
    end

    context 'when host=localhost and per-host[proxyscope]=[direct]' do
      let(:params) { { proxy: { 'host' => 'localhost', 'perhost' => [{ 'scope' => 'proxyscope', 'direct' => true }] } } }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(priority: '01').with_content(
          %r{Acquire::http::proxy::proxyscope "DIRECT";},
        )
      }
    end

    context 'when host=localhost and per-host[proxyscope]=[https][direct]' do
      let(:params) { { proxy: { 'host' => 'localhost', 'perhost' => [{ 'scope' => 'proxyscope', 'https' => true, 'direct' => true }] } } }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(priority: '01').with_content(
          %r{Acquire::https::proxy::proxyscope "DIRECT";},
        )
      }
    end

    context 'when host=localhost and per-host[proxyscope]=proxyhost and per-host[proxyscope2]=proxyhost2' do
      let(:params) { { proxy: { 'host' => 'localhost', 'perhost' => [{ 'scope' => 'proxyscope', 'host' => 'proxyhost' }, { 'scope' => 'proxyscope2', 'host' => 'proxyhost2' }] } } }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(priority: '01').with_content(
          %r{Acquire::http::proxy::proxyscope "http://proxyhost:8080/";},
        ).with_content(
          %r{Acquire::http::proxy::proxyscope2 "http://proxyhost2:8080/";},
        )
      }
    end

    context 'when host=localhost and port=8180' do
      let(:params) { { proxy: { 'host' => 'localhost', 'port' => 8180 } } }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(priority: '01').with_content(
          %r{Acquire::http::proxy "http://localhost:8180/";},
        ).without_content(
          %r{Acquire::https::proxy },
        )
      }
    end

    context 'when host=localhost and https=true' do
      let(:params) { { proxy: { 'host' => 'localhost', 'https' => true } } }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(priority: '01').with_content(
          %r{Acquire::http::proxy "http://localhost:8080/";},
        ).with_content(
          %r{Acquire::https::proxy "https://localhost:8080/";},
        )
      }
    end

    context 'when host=localhost and direct=true' do
      let(:params) { { proxy: { 'host' => 'localhost', 'direct' => true } } }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(priority: '01').with_content(
          %r{Acquire::http::proxy "http://localhost:8080/";},
        ).with_content(
          %r{Acquire::https::proxy "DIRECT";},
        )
      }
    end

    context 'when host=localhost and https=true and direct=true' do
      let(:params) { { proxy: { 'host' => 'localhost', 'https' => true, 'direct' => true } } }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(priority: '01').with_content(
          %r{Acquire::http::proxy "http://localhost:8080/";},
        ).with_content(
          %r{Acquire::https::proxy "https://localhost:8080/";},
        )
      }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(priority: '01').with_content(
          %r{Acquire::http::proxy "http://localhost:8080/";},
        ).without_content(
          %r{Acquire::https::proxy "DIRECT";},
        )
      }
    end

    context 'when ensure=absent' do
      let(:params) { { proxy: { 'ensure' => 'absent' } } }

      it {
        expect(subject).to contain_apt__setting('conf-proxy').with(ensure: 'absent',
                                                                   priority: '01')
      }
    end
  end

  context 'with lots of non-defaults - one' do
    let :params do
      {
        update: { 'frequency' => 'always', 'timeout' => 1, 'tries' => 3 },
        purge: { 'sources.list' => false, 'sources.list.d' => false,
                 'preferences' => false, 'preferences.d' => false,
                 'apt.conf.d' => false }
      }
    end

    it {
      expect(subject).to contain_file('sources.list').with(content: nil)
    }

    it {
      expect(subject).to contain_file('sources.list.d').with(purge: false,
                                                             recurse: false)
    }

    it {
      expect(subject).to contain_file('preferences').with(ensure: 'file')
    }

    it {
      expect(subject).to contain_file('preferences.d').with(purge: false,
                                                            recurse: false)
    }

    it {
      expect(subject).to contain_file('apt.conf.d').with(purge: false,
                                                         recurse: false)
    }

    it {
      expect(subject).to contain_exec('apt_update').with(refreshonly: false,
                                                         timeout: 1,
                                                         tries: 3)
    }
  end

  context 'with lots of non-defaults - two' do
    let :params do
      {
        update: { 'frequency' => 'always', 'timeout' => 1, 'tries' => 3 },
        purge: { 'sources.list' => true, 'sources.list.d' => true,
                 'preferences' => true, 'preferences.d' => true,
                 'apt.conf.d' => true }
      }
    end

    it {
      expect(subject).to contain_file('sources.list').with(content: "# Repos managed by puppet.\n")
    }

    it {
      expect(subject).to contain_file('sources.list.d').with(purge: true,
                                                             recurse: true)
    }

    it {
      expect(subject).to contain_file('preferences').with(ensure: 'absent')
    }

    it {
      expect(subject).to contain_file('preferences.d').with(purge: true,
                                                            recurse: true)
    }

    it {
      expect(subject).to contain_file('apt.conf.d').with(purge: true,
                                                         recurse: true)
    }

    it {
      expect(subject).to contain_exec('apt_update').with(refreshonly: false,
                                                         timeout: 1,
                                                         tries: 3)
    }
  end

  context 'with defaults for sources_list_force' do
    let :params do
      {
        update: { 'frequency' => 'always', 'timeout' => 1, 'tries' => 3 },
        purge: { 'sources.list' => true },
        sources_list_force: false
      }
    end

    it {
      expect(subject).to contain_file('sources.list').with(content: "# Repos managed by puppet.\n")
    }
  end

  context 'with non defaults for sources_list_force' do
    let :params do
      {
        update: { 'frequency' => 'always', 'timeout' => 1, 'tries' => 3 },
        purge: { 'sources.list' => true },
        sources_list_force: true
      }
    end

    it {
      expect(subject).to contain_file('sources.list').with(ensure: 'absent')
    }
  end

  context 'with entries for /etc/apt/auth.conf' do
    facts_hash = {
      'Ubuntu 18.04' => {
        os: {
          family: 'Debian',
          name: 'Ubuntu',
          release: {
            major: '18',
            full: '18.04'
          },
          distro: {
            codename: 'bionic',
            id: 'Ubuntu'
          }
        }
      },
      'Debian 9.0' => {
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
      },
      'Debian 10.0' => {
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
    }

    facts_hash.each do |os, facts|
      context "when on #{os}" do
        let(:facts) do
          facts
        end
        let(:params) do
          {
            auth_conf_entries: [
              {
                machine: 'deb.example.net',
                login: 'foologin',
                password: 'secret'
              },
              {
                machine: 'apt.example.com',
                login: 'aptlogin',
                password: 'supersecret'
              },
            ]
          }
        end

        context 'with manage_auth_conf => true' do
          let(:params) do
            super().merge(manage_auth_conf: true)
          end

          auth_conf_content = <<~CONTENT
            // This file is managed by Puppet. DO NOT EDIT.
            machine deb.example.net login foologin password secret
            machine apt.example.com login aptlogin password supersecret
          CONTENT

          it {
            expect(subject).to contain_file('/etc/apt/auth.conf').with(ensure: 'present',
                                                                       owner: '_apt',
                                                                       group: 'root',
                                                                       mode: '0600',
                                                                       notify: 'Class[Apt::Update]',
                                                                       content: sensitive(auth_conf_content))
          }
        end

        context 'with manage_auth_conf => false' do
          let(:params) do
            super().merge(manage_auth_conf: false)
          end

          it {
            expect(subject).not_to contain_file('/etc/apt/auth.conf')
          }
        end
      end

      context 'with improperly specified entries for /etc/apt/auth.conf' do
        let(:params) do
          {
            auth_conf_entries: [
              {
                machinn: 'deb.example.net',
                username: 'foologin',
                password: 'secret'
              },
              {
                machine: 'apt.example.com',
                login: 'aptlogin',
                password: 'supersecret'
              },
            ]
          }
        end

        it { is_expected.to raise_error(Puppet::Error) }
      end
    end
  end

  context 'with sources defined on valid os.family' do
    let :facts do
      {
        os: {
          family: 'Debian',
          name: 'Ubuntu',
          release: {
            major: '18',
            full: '18.04'
          },
          distro: {
            codename: 'bionic',
            id: 'Ubuntu'
          }
        }
      }
    end
    let(:params) do
      { sources: {
        'debian_unstable' => {
          'location' => 'http://debian.mirror.iweb.ca/debian/',
          'release' => 'unstable',
          'repos' => 'main contrib non-free',
          'key' => { 'id' => '150C8614919D8446E01E83AF9AA38DCD55BE302B', 'server' => 'subkeys.pgp.net' },
          'pin' => '-10',
          'include' => { 'src' => true }
        },
        'puppetlabs' => {
          'location' => 'http://apt.puppetlabs.com',
          'repos' => 'main',
          'key' => { 'id' => '6F6B15509CF8E59E6E469F327F438280EF8D349F', 'server' => 'pgp.mit.edu' }
        }
      } }
    end

    it {
      expect(subject).to contain_apt__setting('list-debian_unstable').with(ensure: 'present')
    }

    it { is_expected.to contain_file('/etc/apt/sources.list.d/debian_unstable.list').with_content(%r{^deb http://debian.mirror.iweb.ca/debian/ unstable main contrib non-free$}) }
    it { is_expected.to contain_file('/etc/apt/sources.list.d/debian_unstable.list').with_content(%r{^deb-src http://debian.mirror.iweb.ca/debian/ unstable main contrib non-free$}) }

    it {
      expect(subject).to contain_apt__setting('list-puppetlabs').with(ensure: 'present')
    }

    it { is_expected.to contain_file('/etc/apt/sources.list.d/puppetlabs.list').with_content(%r{^deb http://apt.puppetlabs.com bionic main$}) }
  end

  context 'with confs defined on valid os.family' do
    let :facts do
      {
        os: {
          family: 'Debian',
          name: 'Ubuntu',
          release: {
            major: '18',
            full: '18.04'
          },
          distro: {
            codename: 'bionic',
            id: 'Ubuntu'
          }
        }
      }
    end
    let(:params) do
      { confs: {
        'foo' => {
          'content' => 'foo'
        },
        'bar' => {
          'content' => 'bar'
        }
      } }
    end

    it {
      expect(subject).to contain_apt__conf('foo').with(content: 'foo')
    }

    it {
      expect(subject).to contain_apt__conf('bar').with(content: 'bar')
    }
  end

  context 'with keys defined on valid os.family' do
    let :facts do
      {
        os: {
          family: 'Debian',
          name: 'Ubuntu',
          release: {
            major: '18',
            full: '18.04'
          },
          distro: {
            codename: 'bionic',
            id: 'Ubuntu'
          }
        }
      }
    end
    let(:params) do
      { keys: {
        '55BE302B' => {
          'server' => 'subkeys.pgp.net'
        },
        'EF8D349F' => {
          'server' => 'pgp.mit.edu'
        }
      } }
    end

    it {
      expect(subject).to contain_apt__key('55BE302B').with(server: 'subkeys.pgp.net')
    }

    it {
      expect(subject).to contain_apt__key('EF8D349F').with(server: 'pgp.mit.edu')
    }
  end

  context 'with ppas defined on valid os.family' do
    let :facts do
      {
        os: {
          family: 'Debian',
          name: 'Ubuntu',
          release: {
            major: '18',
            full: '18.04'
          },
          distro: {
            codename: 'bionic',
            id: 'Ubuntu'
          }
        }
      }
    end
    let(:params) do
      { ppas: {
        'ppa:drizzle-developers/ppa' => {},
        'ppa:nginx/stable' => {}
      } }
    end

    it { is_expected.to contain_apt__ppa('ppa:drizzle-developers/ppa') }
    it { is_expected.to contain_apt__ppa('ppa:nginx/stable') }
  end

  context 'with settings defined on valid os.family' do
    let :facts do
      {
        os: {
          family: 'Debian',
          name: 'Ubuntu',
          release: {
            major: '18',
            full: '18.04'
          },
          distro: {
            codename: 'bionic',
            id: 'Ubuntu'
          }
        }
      }
    end
    let(:params) do
      { settings: {
        'conf-banana' => { 'content' => 'banana' },
        'pref-banana' => { 'content' => 'banana' }
      } }
    end

    it { is_expected.to contain_apt__setting('conf-banana') }
    it { is_expected.to contain_apt__setting('pref-banana') }
  end

  context 'with pins defined on valid os.family' do
    let :facts do
      {
        os: {
          family: 'Debian',
          name: 'Ubuntu',
          release: {
            major: '18',
            full: '18.04'
          },
          distro: {
            codename: 'bionic',
            id: 'Ubuntu'
          }
        }
      }
    end
    let(:params) do
      { pins: {
        'stable' => { 'priority' => 600, 'order' => 50 },
        'testing' => { 'priority' => 700, 'order' => 100 }
      } }
    end

    it { is_expected.to contain_apt__pin('stable') }
    it { is_expected.to contain_apt__pin('testing') }
  end

  describe 'failing tests' do
    context "with purge['sources.list']=>'banana'" do
      let(:params) { { purge: { 'sources.list' => 'banana' } } }

      it do
        expect(subject).to raise_error(Puppet::Error)
      end
    end

    context "with purge['sources.list.d']=>'banana'" do
      let(:params) { { purge: { 'sources.list.d' => 'banana' } } }

      it do
        expect(subject).to raise_error(Puppet::Error)
      end
    end

    context "with purge['preferences']=>'banana'" do
      let(:params) { { purge: { 'preferences' => 'banana' } } }

      it do
        expect(subject).to raise_error(Puppet::Error)
      end
    end

    context "with purge['preferences.d']=>'banana'" do
      let(:params) { { purge: { 'preferences.d' => 'banana' } } }

      it do
        expect(subject).to raise_error(Puppet::Error)
      end
    end

    context "with purge['apt.conf.d']=>'banana'" do
      let(:params) { { purge: { 'apt.conf.d' => 'banana' } } }

      it do
        expect(subject).to raise_error(Puppet::Error)
      end
    end
  end
end

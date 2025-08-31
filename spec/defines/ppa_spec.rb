# frozen_string_literal: true

require 'spec_helper'

def ppa_exec_params(user, repo, distro = 'trusty', environment = [])
  [
    environment:,
    command: "/opt/puppetlabs/puppet/cache/add-apt-repository-#{user}-ubuntu-#{repo}-#{distro}.sh",
    logoutput: 'on_failure',
  ]
end

describe 'apt::ppa' do
  let :pre_condition do
    'class { "apt": }'
  end

  describe 'defaults' do
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
            codename: 'trusty',
            id: 'Ubuntu'
          }
        },
        puppet_vardir: '/opt/puppetlabs/puppet/cache'
      }
    end

    let(:title) { 'ppa:needs/substitution' }

    it { is_expected.not_to contain_package('python-software-properties') }

    it {
      expect(subject).to contain_exec('add-apt-repository-ppa:needs/substitution')
        .that_notifies('Class[Apt::Update]')
        .with(*ppa_exec_params('needs', 'substitution'))
    }
  end

  [
    'ppa:foo/bar',
    'ppa:foo/bar1.0',
    'ppa:foo10/bar10',
    'ppa:foo-/bar_',
  ].each do |value|
    describe 'valid resource names' do
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
              codename: 'trusty',
              id: 'Ubuntu'
            }
          }
        }
      end

      let(:title) { value }

      it { is_expected.not_to raise_error }
      it { is_expected.to contain_exec("add-apt-repository-#{value}") }
    end
  end

  [
    'ppa:foo!/bar',
    'ppa:foo/bar!',
    'ppa:foo1,0/bar',
    'ppa:foo/bar/foobar',
    '|| ls -la ||',
    '|| touch /tmp/foo.txt ||',
  ].each do |value|
    describe 'invalid resource names' do
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
              codename: 'trusty',
              id: 'Ubuntu'
            }
          }
        }
      end

      let(:title) { value }

      it { is_expected.to raise_error(Puppet::PreformattedError, %r{Invalid PPA name: #{value}}) }
    end
  end

  describe 'Ubuntu 15.10 sources.list filename' do
    let :facts do
      {
        os: {
          family: 'Debian',
          name: 'Ubuntu',
          release: {
            major: '15',
            full: '15.10'
          },
          distro: {
            codename: 'wily',
            id: 'Ubuntu'
          }
        },
        puppet_vardir: '/opt/puppetlabs/puppet/cache'
      }
    end

    let(:title) { 'ppa:user/foo' }

    it {
      expect(subject).to contain_exec('add-apt-repository-ppa:user/foo')
        .that_notifies('Class[Apt::Update]')
        .with(*ppa_exec_params('user', 'foo', 'wily'))
    }
  end

  describe 'package_name => software-properties-common' do
    let :pre_condition do
      'class { "apt": }'
    end

    let :params do
      {
        package_name: 'software-properties-common',
        package_manage: true
      }
    end

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
            codename: 'trusty',
            id: 'Ubuntu'
          }
        },
        puppet_vardir: '/opt/puppetlabs/puppet/cache'
      }
    end

    let(:title) { 'ppa:needs/substitution' }

    it { is_expected.to contain_package('software-properties-common') }

    it {
      expect(subject).to contain_exec('add-apt-repository-ppa:needs/substitution')
        .that_notifies('Class[Apt::Update]')
        .with(*ppa_exec_params('needs', 'substitution'))
    }
  end

  describe 'package_manage => false' do
    let :pre_condition do
      'class { "apt": }'
    end

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
            codename: 'trusty',
            id: 'Ubuntu'
          }
        },
        puppet_vardir: '/opt/puppetlabs/puppet/cache'
      }
    end

    let :params do
      {
        package_manage: false
      }
    end

    let(:title) { 'ppa:needs/substitution' }

    it { is_expected.not_to contain_package('python-software-properties') }

    it {
      expect(subject).to contain_exec('add-apt-repository-ppa:needs/substitution')
        .that_notifies('Class[Apt::Update]')
        .with(*ppa_exec_params('needs', 'substitution'))
    }
  end

  describe 'apt included, no proxy' do
    let :pre_condition do
      'class { "apt": }
      apt::ppa { "ppa:user/foo2": }
      '
    end

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
            codename: 'trusty',
            id: 'Ubuntu'
          }
        },
        puppet_vardir: '/opt/puppetlabs/puppet/cache'
      }
    end

    let :params do
      {
        package_manage: true,
        require: 'Apt::Ppa[ppa:user/foo2]'
      }
    end

    let(:title) { 'ppa:user/foo' }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_package('software-properties-common') }

    it {
      expect(subject).to contain_exec('add-apt-repository-ppa:user/foo')
        .that_notifies('Class[Apt::Update]')
        .with(*ppa_exec_params('user', 'foo'))
    }
  end

  describe 'apt included, proxy host' do
    let :pre_condition do
      'class { "apt":
        proxy => { "host" => "localhost" },
      }'
    end

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
            codename: 'trusty',
            id: 'Ubuntu'
          }
        },
        puppet_vardir: '/opt/puppetlabs/puppet/cache'
      }
    end

    let :params do
      {
        'package_manage' => true
      }
    end

    let(:title) { 'ppa:user/foo' }

    it { is_expected.to contain_package('software-properties-common') }

    it {
      expect(subject).to contain_exec('add-apt-repository-ppa:user/foo')
        .that_notifies('Class[Apt::Update]')
        .with(*ppa_exec_params('user', 'foo', 'trusty', ['http_proxy=http://localhost:8080']))
    }
  end

  describe 'apt included, proxy host and port' do
    let :pre_condition do
      'class { "apt":
        proxy => { "host" => "localhost", "port" => 8180 },
      }'
    end

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
            codename: 'trusty',
            id: 'Ubuntu'
          }
        },
        puppet_vardir: '/opt/puppetlabs/puppet/cache'
      }
    end

    let :params do
      {
        package_manage: true
      }
    end

    let(:title) { 'ppa:user/foo' }

    it { is_expected.to contain_package('software-properties-common') }

    it {
      expect(subject).to contain_exec('add-apt-repository-ppa:user/foo')
        .that_notifies('Class[Apt::Update]')
        .with(*ppa_exec_params('user', 'foo', 'trusty', ['http_proxy=http://localhost:8180']))
    }
  end

  describe 'apt included, proxy host and port and https' do
    let :pre_condition do
      'class { "apt":
        proxy => { "host" => "localhost", "port" => 8180, "https" => true },
      }'
    end

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
            codename: 'trusty',
            id: 'Ubuntu'
          }
        },
        puppet_vardir: '/opt/puppetlabs/puppet/cache'
      }
    end

    let :params do
      {
        package_manage: true
      }
    end

    let(:title) { 'ppa:user/foo' }

    it { is_expected.to contain_package('software-properties-common') }

    it {
      expect(subject).to contain_exec('add-apt-repository-ppa:user/foo')
        .that_notifies('Class[Apt::Update]')
        .with(*ppa_exec_params('user', 'foo', 'trusty', ['http_proxy=http://localhost:8180', 'https_proxy=https://localhost:8180']))
    }
  end

  describe 'ensure absent' do
    let :pre_condition do
      'class { "apt": }'
    end

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
            codename: 'trusty',
            id: 'Ubuntu'
          }
        },
        puppet_vardir: '/opt/puppetlabs/puppet/cache'
      }
    end

    let(:title) { 'ppa:user/foo' }

    let :params do
      {
        ensure: 'absent'
      }
    end

    it {
      expect(subject).to contain_tidy("remove-apt-repository-script-#{title}")
        .with('path' => '/opt/puppetlabs/puppet/cache/add-apt-repository-user-ubuntu-foo-trusty.sh')

      expect(subject).to contain_tidy("remove-apt-repository-#{title}")
        .with('path' => '/etc/apt/sources.list.d/user-ubuntu-foo-trusty.list')
        .that_notifies('Class[Apt::Update]')
    }
  end

  context 'with validation' do
    describe 'no release' do
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
              codename: nil,
              id: 'Ubuntu'
            }
          }
        }
      end

      let(:title) { 'ppa:user/foo' }

      it do
        expect(subject).to raise_error(Puppet::Error, %r{os.distro.codename fact not available: release parameter required})
      end
    end

    describe 'not ubuntu' do
      let :facts do
        {
          os: {
            family: 'Debian',
            name: 'Debian',
            release: {
              major: '6',
              full: '6.0.7'
            },
            distro: {
              codename: 'wheezy',
              id: 'Debian'
            }
          }
        }
      end

      let(:title) { 'ppa:user/foo' }

      it do
        expect(subject).to raise_error(Puppet::Error, %r{not currently supported on Debian})
      end
    end
  end
end

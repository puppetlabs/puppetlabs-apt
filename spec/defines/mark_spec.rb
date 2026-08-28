# frozen_string_literal: true

require 'spec_helper'

describe 'apt::mark', type: :define do
  let :title do
    'mysource'
  end

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

  context 'with correct seting' do
    let :params do
      {
        'setting' => 'manual'
      }
    end

    it {
      expect(subject).to contain_exec('apt-mark manual mysource')
    }
  end

  context 'guard idempotency' do
    ['auto', 'manual'].each do |setting|
      context "with setting => #{setting}" do
        let :params do
          {
            'setting' => setting
          }
        end

        it 'only runs against a genuinely installed package' do
          expect(subject).to contain_exec("apt-mark #{setting} mysource")
            .with_onlyif(["/usr/bin/dpkg-query --show --showformat '${db:Status-Status}' mysource | grep -qx installed"])
            .with_unless(["/usr/bin/apt-mark show#{setting} mysource | grep mysource -q"])
        end
      end
    end

    context 'with setting => hold' do
      let :params do
        {
          'setting' => 'hold'
        }
      end

      it 'runs for any package dpkg knows of (pre-holding an uninstalled package is legitimate)' do
        expect(subject).to contain_exec('apt-mark hold mysource')
          .with_onlyif([['/usr/bin/dpkg', '-l', 'mysource']])
          .with_unless(['/usr/bin/apt-mark showhold mysource | grep mysource -q'])
      end
    end

    context 'with setting => unhold' do
      let :params do
        {
          'setting' => 'unhold'
        }
      end

      it 'only runs when the package is actually held' do
        expect(subject).to contain_exec('apt-mark unhold mysource')
          .with_onlyif(['/usr/bin/apt-mark showhold mysource | grep -q .'])
      end
    end
  end

  describe 'with wrong setting' do
    let :params do
      {
        'setting' => 'foobar'
      }
    end

    it do
      expect(subject).to raise_error(Puppet::PreformattedError, %r{expects a match for Enum\['auto', 'hold', 'manual', 'unhold'\], got 'foobar'})
    end
  end

  [
    'package',
    'package1',
    'package.name',
    'package-name',
    'package+name',
    'p.ackagename',
    'p+ackagename',
    'p+',
  ].each do |value|
    describe 'with a valid resource title' do
      let :title do
        value
      end

      let :params do
        {
          'setting' => 'manual'
        }
      end

      it do
        expect(subject).to contain_exec("apt-mark manual #{title}")
      end
    end
  end

  # packagenames starting with + are not valid as the title according to puppet
  # good thing this is also an illegal name for debian packages
  [
    '|| ls -la ||',
    'packakge with space',
    'package<>|',
    '|| touch /tmp/foo.txt ||',
    'package_name',
    'PackageName',
    '.p',
    'p',
  ].each do |value|
    describe "with an invalid resource title [#{value}]" do
      let :title do
        value
      end

      let :params do
        {
          'setting' => 'manual'
        }
      end

      it do
        expect(subject).to raise_error(Puppet::PreformattedError, %r{Invalid package name: #{title}})
      end
    end
  end
end

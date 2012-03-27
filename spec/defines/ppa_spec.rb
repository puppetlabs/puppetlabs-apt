require 'spec_helper'
describe 'apt::ppa', :type => :define do
  ['ppa:dans_ppa', 'dans_ppa','ppa:dans-daily/ubuntu'].each do |t|
    describe "with title #{t}" do
      let :pre_condition do
        'class { "apt": }'
      end
      let :facts do
        {:lsbdistcodename => 'natty'}
      end
      let :title do
        t
      end
      let :release do
        "natty"
      end
      let :filename do
        t.sub(/^ppa:/,'').gsub('/','-') << "-" << "#{release}.list"
      end
      let :update_options do
        [
          "-o Dir::Etc::SourceList=/etc/apt/sources.list.d/#{filename}",
          '-o Dir::Etc::SourceParts=/dev/null',
          '--no-list-cleanup',
        ].join(' ')
      end

      it { should contain_exec("apt::ppa #{t} apt_update").with(
        'command'     => "/usr/bin/apt-get update #{update_options}",
        'refreshonly' => true
        )
      }

      it { should contain_exec("add-apt-repository-#{t}").with(
        'command' => "/usr/bin/add-apt-repository #{t}",
        'notify'  => "Exec[apt::ppa #{t} apt_update]",
        'creates' => "/etc/apt/sources.list.d/#{filename}"
        )
      }

      it { should create_file("/etc/apt/sources.list.d/#{filename}").with(
        'ensure'  => 'file',
        'require' => "Exec[add-apt-repository-#{t}]"
        )
      }
    end
  end

  describe "without Class[apt] should raise a Puppet::Error" do
    let(:release) { "natty" }
    let(:title) { "ppa" }
    it { expect { should contain_apt__ppa(title) }.to raise_error(Puppet::Error) }
  end

  describe "without release should raise a Puppet::Error" do
    let(:title) { "ppa:" }
    it { expect { should contain_apt__ppa(:release) }.to raise_error(Puppet::Error) }
  end

end

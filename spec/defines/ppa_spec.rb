require 'spec_helper'
describe 'apt::ppa', :type => :define do
  ['ppa:dans_ppa', 'dans_ppa'].each do |t|
    describe "with title #{t}" do
      let :pre_condition do
        'class { "apt": }'
      end
      let :title do
        t
      end
      let :unless_statement do
        if t =~ /ppa:(.*)/
          /^[^#].*ppa.*#{$1}.*$/
        else
          /^[^#].*#{t}.*$/
        end
      end
      it { should contain_exec("add-apt-repository-#{t}").with(
        'command' => "/usr/bin/add-apt-repository #{t}",
        'notify'  => "Exec[apt-update-#{t}]"
        )
      }
      it { should contain_exec("add-apt-repository-#{t}").with({"unless" => unless_statement}) }
      it { should contain_exec("apt-update-#{t}").with(
        'command'     => '/usr/bin/aptitude update',
        'refreshonly' => true
        )
      }
      it { should contain_exec("apt-update-#{t}").without_unless }
    end
  end

  describe "without Class[apt] should raise a Puppet::Error" do
    let(:title) { "ppa" }
    it { expect { should contain_apt__ppa(title) }.to raise_error(Puppet::Error) }
  end
end

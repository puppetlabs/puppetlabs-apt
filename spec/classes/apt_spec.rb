require 'spec_helper'
describe 'apt', :type => :class do
  let :default_params do
    {
      :disable_keys => false,
      :always_apt_update => false,
      :purge => false
    }
  end

  [{},
   {
      :disable_keys => true,
      :always_apt_update => true,
      :purge => true 
    }
  ].each do |param_set|
    describe "when #{param_set == {} ? "using default" : "specifying"} class parameters" do
      let :param_hash do
        default_params.merge(param_set)
      end

      let :params do
        param_set
      end

      let :refresh_only_apt_update do
        if param_hash[:always_apt_update]
          false
        else
          true
        end
      end

      it { should include_class("apt::params") }

      it { should contain_package("python-software-properties") }

      it {
        if param_hash[:purge]
        should contain_file("sources.list").with({
            'path'    => "/etc/apt/sources.list",
            'ensure'  => "present",
            'owner'   => "root",
            'group'   => "root",
            'mode'    => 644,
            "content" => "# Repos managed by puppet.\n" 
          })
        else
        should contain_file("sources.list").with({
            'path'    => "/etc/apt/sources.list",
            'ensure'  => "present",
            'owner'   => "root",
            'group'   => "root",
            'mode'    => 644,
            'content' => nil
          })
        end
      }
      it {
        if param_hash[:purge]
          should create_file("sources.list.d").with({
            'path'    => "/etc/apt/sources.list.d",
            'ensure'  => "directory",
            'owner'   => "root",
            'group'   => "root",
            'purge'   => true,
            'recurse' => true
          })
        else
          should create_file("sources.list.d").with({
            'path'    => "/etc/apt/sources.list.d",
            'ensure'  => "directory",
            'owner'   => "root",
            'group'   => "root",
            'purge'   => false,
            'recurse' => false
          })
        end
      }

      it {
        should contain_exec("apt_update").with({
          'command'     => "/usr/bin/apt-get update",
          'subscribe'   => ["File[sources.list]", "File[sources.list.d]"],
          'refreshonly' => refresh_only_apt_update
        })
      }

      it {
        if param_hash[:disable_keys]
          should contain_exec("make-apt-insecure").with({
            'command'   => '/bin/echo "APT::Get::AllowUnauthenticated 1;" >> /etc/apt/apt.conf.d/99unauth',
            'creates'   => '/etc/apt/apt.conf.d/99unauth'
          })
        else
          should_not contain_exec("make-apt-insecure").with({
            'command'   => '/bin/echo "APT::Get::AllowUnauthenticated 1;" >> /etc/apt/apt.conf.d/99unauth',
            'creates'   => '/etc/apt/apt.conf.d/99unauth'
          })
        end
      }
    end
  end
end

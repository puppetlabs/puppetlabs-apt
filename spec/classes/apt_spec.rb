require 'spec_helper'
describe 'apt', :type => :class do
  let :default_params do
    {
      :disable_keys => :undef,
      :always_apt_update => false,
      :purge_sources_list => false,
      :purge_sources_list_d => false,
    }
  end

  [{},
    {
      :disable_keys => true,
      :always_apt_update => true,
      :proxy_host => true,
      :proxy_port => '3128',
      :purge_sources_list => true,
      :purge_sources_list_d => true,
    },
    {
      :disable_keys => false
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
        if param_hash[:purge_sources_list]
        should contain_file("/etc/apt/sources.list").with({
            'alias'   => "sources.list",
            'ensure'  => "present",
            'owner'   => "root",
            'group'   => "root",
            'mode'    => 644,
            "content" => "# Repos managed by puppet.\n"
          })
        else
        should contain_file("/etc/apt/sources.list").with({
            'alias'   => "sources.list",
            'ensure'  => "present",
            'owner'   => "root",
            'group'   => "root",
            'mode'    => 644,
            'content' => nil
          })
        end
      }
      it {
        if param_hash[:purge_sources_list_d]
          should create_file("/etc/apt/sources.list.d").with({
            'alias'   => "sources.list.d",
            'ensure'  => "directory",
            'owner'   => "root",
            'group'   => "root",
            'purge'   => true,
            'recurse' => true
          })
        else
          should create_file("/etc/apt/sources.list.d").with({
            'alias'   => "sources.list.d",
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
        if param_hash[:disable_keys] == true
          should create_file("99unauth").with({
            'content' => "APT::Get::AllowUnauthenticated 1;\n",
            'ensure'  => "present",
            'path'    => "/etc/apt/apt.conf.d/99unauth"
          })
        elsif param_hash[:disable_keys] == false
          should create_file("99unauth").with({
            'ensure' => "absent",
            'path'   => "/etc/apt/apt.conf.d/99unauth"
          })
        elsif param_hash[:disable_keys] != :undef
          should_not create_file("99unauth").with({
            'path'   => "/etc/apt/apt.conf.d/99unauth"
          })
        end
      }
      describe 'when setting a proxy' do
        it {
          if param_hash[:proxy_host]
            should contain_file('configure-apt-proxy').with(
              'path'    => '/etc/apt/apt.conf.d/proxy',
              'content' => "Acquire::http::Proxy \"http://#{param_hash[:proxy_host]}:#{param_hash[:proxy_port]}\";"
            )
          else
            should_not contain_file('configure_apt_proxy')
          end
        }
      end
    end
  end

  describe "it should not error if package['python-software-properties'] is already defined" do
    let(:pre_condition) { 'package { "python-software-properties": }->Class["Apt"]' }
    it { should contain_package("python-software-properties") }
  end

  describe "it should make other modules fail when checking file['/etc/apt/sources.list.d']" do
    let (:post_condition) { 'if ! defined(File["/etc/apt/sources.list.d"]) { file { "/etc/apt/sources.list.d": ensure => directory } }' }
    it { should contain_file("/etc/apt/sources.list.d") }
  end
end

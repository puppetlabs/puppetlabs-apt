require 'spec_helper'
describe 'apt::force', :type => :define do

  let :title do
    'my_package'
  end

  [false, '1'].each do |version|
    describe "with version: #{version}" do
      let :params do
        {:version => version, :release => 'testing'}
      end
      let :unless_query do
        base_command = "/usr/bin/dpkg -s #{title} | grep -q "
        base_command + (version ? "'Version: #{params[:version]}'" : "'Status: install'")
      end
      let :exec_title do
        base_exec = "/usr/bin/aptitude -y -t #{params[:release]} install #{title}"
        base_exec + (version ? "=#{version}" : "")
      end
      it { should contain_exec(exec_title).with_unless(unless_query) }
    end
  end
end

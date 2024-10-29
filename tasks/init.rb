#!/opt/puppetlabs/puppet/bin/ruby
# frozen_string_literal: true

require 'json'
require 'open3'
require 'puppet'

def apt_get(action)
  cmd = ['apt-get', action]
  cmd << '-y' if ['upgrade', 'dist-upgrade', 'autoremove'].include?(action)
  if ['upgrade', 'dist-upgrade', 'autoremove'].include?(action)
    ENV['DEBIAN_FRONTEND'] = 'noninteractive'
    cmd << '-o'
    cmd << 'Dpkg::Options="--force-confdef"'
    cmd << '-o'
    cmd << 'Dpkg::Options="--force-confold"'
  end
  stdout, stderr, status = Open3.capture3(*cmd)
  raise Puppet::Error, stderr if status != 0

  { status: stdout.strip }
end

params = JSON.parse($stdin.read)
action = params['action']

begin
  result = apt_get(action)
  puts result.to_json
  exit 0
rescue Puppet::Error => e
  puts({ status: 'failure', error: e.message }.to_json)
  exit 1
end

require 'uri'

module Puppet::Parser::Functions
	newfunction(:url_host, :type => :rvalue) do |args|
		URI.parse(args[0]).host
	end
end

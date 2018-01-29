#!/usr/bin/ruby

require 'facter'

Facter.add(:package_versions) do
  setcode do
    package_hash = {}

    dpkg_out = Facter::Util::Resolution.exec("dpkg -l").split("\n")

    # get rid of the headings
    dpkg_out.shift(5)

    dpkg_out.each do | line |
      l = line.split
      package_hash[l[1].chomp(':amd64')] = l[2]
    end

    package_hash
  end

end

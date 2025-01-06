# frozen_string_literal: true

# This fact lists the .list filenames that are used by apt.
Facter.add(:apt_sources) do
  confine osfamily: 'Debian'
  setcode do
    sources = ['sources.list']
    Dir.glob('/etc/apt/sources.list.d/*.{list,sources}').each do |file|
      sources.push(File.basename(file))
    end
    sources
  end
end

apt_package_updates = nil
Facter.add('apt_has_updates') do
  confine osfamily: 'Debian'
  if File.executable?('/usr/bin/apt-get')
    apt_get_result = Facter::Util::Resolution.exec('/usr/bin/apt-get -s -o Debug::NoLocking=true upgrade 2>&1')
    unless apt_get_result.nil?
      apt_package_updates = [[], []]
      apt_get_result.each_line do |line|
        next unless line =~ %r{^Inst\s}
        package = line.gsub(%r{^Inst\s([^\s]+)\s.*}, '\1').strip
        apt_package_updates[0].push(package)
        security_matches = [
          %r{ Debian[^\s]+-updates },
          %r{ Debian-Security:},
          %r{ Ubuntu[^\s]+-security },
          %r{ gNewSense[^\s]+-security },
        ]
        re = Regexp.union(security_matches)
        apt_package_updates[1].push(package) if line.match(re)
      end
    end
  end

  setcode do
    if !apt_package_updates.nil? && apt_package_updates.length == 2
      apt_package_updates != [[], []]
    end
  end
end

Facter.add('apt_package_updates') do
  confine apt_has_updates: true
  setcode do
    if Facter.version < '2.0.0'
      apt_package_updates[0].join(',')
    else
      apt_package_updates[0]
    end
  end
end

Facter.add('apt_updates') do
  confine apt_has_updates: true
  setcode do
    Integer(apt_package_updates[0].length)
  end
end

Facter.add('apt_security_updates') do
  confine apt_has_updates: true
  setcode do
    Integer(apt_package_updates[1].length)
  end
end

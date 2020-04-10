# Executes the upgrading of packages
# @param
#   upgrade_option Type of upgrade passed into apt-get command arguments i.e. 'upgrade' or 'dist-upgrade'
def get_updates(upgrade_option)
  apt_updates = nil
  if File.executable?('/usr/bin/apt-get')
    apt_get_result = Facter::Util::Resolution.exec("/usr/bin/apt-get -s -o Debug::NoLocking=true #{upgrade_option} 2>&1")
    unless apt_get_result.nil?
      apt_updates = [[], []]
      apt_get_result.each_line do |line|
        next unless line =~ %r{^Inst\s}
        package = line.gsub(%r{^Inst\s([^\s]+)\s.*}, '\1').strip
        apt_updates[0].push(package)
        security_matches = [
          %r{ Debian-Security:},
          %r{ Ubuntu[^\s]+-security[, ]},
          %r{ gNewSense[^\s]+-security[, ]},
        ]
        re = Regexp.union(security_matches)
        if line.match(re)
          apt_updates[1].push(package)
        end
      end
    end
  end

  apt_updates
end

def has_update(updates)
  if !updates.nil? && updates.length == 2
    updates != [[], []]
  end
end

Facter.add('apt_has_updates') do
  confine osfamily: 'Debian'
  setcode do
    apt_package_updates = get_updates('upgrade')
    has_update(apt_package_updates)
  end
end

Facter.add('apt_has_dist_updates') do
  confine osfamily: 'Debian'
  setcode do
    apt_dist_updates = get_updates('dist-upgrade')
    has_update(apt_dist_updates)
  end
end

Facter.add('apt_package_updates') do
  confine apt_has_updates: true
  setcode do
    apt_package_updates = get_updates('upgrade')
    apt_package_updates[0]
  end
end

Facter.add('apt_package_dist_updates') do
  confine apt_has_dist_updates: true
  setcode do
    apt_dist_updates = get_updates('dist-upgrade')
    apt_dist_updates[0]
  end
end

Facter.add('apt_package_security_updates') do
  confine apt_has_updates: true
  setcode do
    apt_package_updates = get_updates('upgrade')
    apt_package_updates[1]
  end
end

Facter.add('apt_package_security_dist_updates') do
  confine apt_has_dist_updates: true
  setcode do
    apt_dist_updates = get_updates('dist-upgrade')
    apt_dist_updates[1]
  end
end

Facter.add('apt_updates') do
  confine apt_has_updates: true
  setcode do
    apt_package_updates = get_updates('upgrade')
    Integer(apt_package_updates[0].length)
  end
end

Facter.add('apt_dist_updates') do
  confine apt_has_dist_updates: true
  setcode do
    apt_dist_updates = get_updates('dist-upgrade')
    Integer(apt_dist_updates[0].length)
  end
end

Facter.add('apt_security_updates') do
  confine apt_has_updates: true
  setcode do
    apt_package_updates = get_updates('upgrade')
    Integer(apt_package_updates[1].length)
  end
end

Facter.add('apt_security_dist_updates') do
  confine apt_has_dist_updates: true
  setcode do
    apt_dist_updates = get_updates('dist-upgrade')
    Integer(apt_dist_updates[1].length)
  end
end

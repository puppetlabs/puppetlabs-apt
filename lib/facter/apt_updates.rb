Facter.add("apt_has_updates") do
  confine :osfamily => 'Debian'
  if File.executable?("/usr/lib/update-notifier/apt-check")
    apt_package_updates = Facter::Util::Resolution.exec('/usr/lib/update-notifier/apt-check 2>&1').split(';')
  else
    apt_package_updates = ['31337', '31337']
  end
  setcode do
    apt_package_updates
  end
end

Facter.add("apt_package_updates") do
  confine :apt_has_updates => true
  if File.executable?("/usr/lib/update-notifier/apt-check")
    packages = Facter::Util::Resolution.exec('/usr/lib/update-notifier/apt-check -p 2>&1').split("\n")
  else
    packages = ['update-notifier-common']
  end
  setcode do
    if Facter.version < '2.0.0'
      packages.join(',')
    else
      packages
    end
  end
end

Facter.add("apt_updates") do
  confine :apt_has_updates => true
  setcode do
    Integer(apt_package_updates[0])
  end
end

Facter.add("apt_security_updates") do
  confine :apt_has_updates => true
  setcode do
    Integer(apt_package_updates[1])
  end
end

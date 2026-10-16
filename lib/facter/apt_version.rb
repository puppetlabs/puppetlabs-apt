# frozen_string_literal: true

Facter.add(:apt_version) do
  confine 'os.family': 'Debian'
  setcode do
    if File.executable?('/usr/bin/apt-get')
      output = Facter::Core::Execution.execute('/usr/bin/apt-get --version', on_fail: nil)
      output&.match(%r{\Aapt (\d+(?:\.\d+)+)\S* })&.[](1)
    end
  end
end

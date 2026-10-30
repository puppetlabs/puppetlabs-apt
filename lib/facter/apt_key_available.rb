# frozen_string_literal: true

# Whether the apt-key command is available. It was removed in apt 3
# (Debian 13, Ubuntu 26.04).
Facter.add(:apt_key_available) do
  confine 'os.family': 'Debian'
  setcode { !Facter::Core::Execution.which('apt-key').nil? }
end

# frozen_string_literal: true

UNSUPPORTED_PLATFORMS = ['RedHat', 'Suse', 'windows', 'AIX', 'Solaris'].freeze
RETRY_WAIT            = 3
ERROR_MATCHER         = %r{(no valid OpenPGP data found|keyserver timed out|keyserver receive failed|shell failed|apply manifest failed)}.freeze
MAX_RETRY_COUNT       = 10

RSpec.configure do |c|
  c.before :suite do
    # lsb-release is needed for facter 3 (puppet 6) to resolve os.distro facts. Not needed with facter
    # 4 (puppet 7).
    lsb_package = <<~MANIFEST
      package { 'lsb-release':
        ensure => installed,
      }
    MANIFEST
    include PuppetLitmus
    extend PuppetLitmus
    apply_manifest(lsb_package)
  end
end

# This method allows a block to be passed in and if an exception is raised
# that matches the 'error_matcher' matcher, the block will wait a set number
# of seconds before retrying.
# Params:
# - max_retry_count - Max number of retries
# - retry_wait_interval_secs - Number of seconds to wait before retry
# - error_matcher - Matcher which the exception raised must match to allow retry
# Example Usage:
# retry_on_error_matching(3, 5, /OpenGPG Error/) do
#   apply_manifest(pp, :catch_failures => true)
# end

def retry_on_error_matching(max_retry_count = MAX_RETRY_COUNT, retry_wait_interval_secs = RETRY_WAIT, error_matcher = ERROR_MATCHER)
  try = 0
  begin
    puts "retry_on_error_matching: try #{try}" unless try.zero?
    try += 1
    yield
  rescue StandardError => e
    raise('Attempted this %{value0} times. Raising %{value1}' % { value0: max_retry_count, value1: e }) unless try < max_retry_count && (error_matcher.nil? || e.message =~ error_matcher)

    sleep retry_wait_interval_secs
    retry
  end
end

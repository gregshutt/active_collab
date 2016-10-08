$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'active_collab'
require 'rspec'
require 'webmock/rspec'
require 'vcr'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |c|
  c.configure_rspec_metadata!

  c.filter_sensitive_data("<ACTIVECOLLAB_USERNAME>") do
    ENV['ACTIVECOLLAB_TEST_USERNAME']
  end

  c.filter_sensitive_data("<ACTIVECOLLAB_PASSWORD>") do
    ENV['ACTIVECOLLAB_TEST_PASSWORD']
  end

  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :new_episodes }
end

# The username for the activecollab account to use during testing.
#
# @return The account's username.
def activecollab_username
  ENV.fetch 'ACTIVECOLLAB_TEST_USERNAME'
end

# The password for the reddit account to use during testing.
#
# @return The account's password.
def activecollab_password
  ENV.fetch 'ACTIVECOLLAB_TEST_PASSWORD'
end
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "active_collab"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
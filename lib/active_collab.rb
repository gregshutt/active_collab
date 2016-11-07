require 'active_collab/version'
require 'active_collab/client'
require 'active_collab/configuration'

module ActiveCollab
  def self.reset
    @configuration = Configuration.new
  end
  
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end
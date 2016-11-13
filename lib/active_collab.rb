require 'active_collab/version'
require 'active_collab/client'
require 'active_collab/configuration'

module ActiveCollab
  class << self
    def client
      @client ||= ActiveCollab::Client.new
    end

    def reset
      @configuration = Configuration.new
    end
    
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
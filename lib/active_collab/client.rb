require 'httparty'

require 'active_collab/client/account'

module ActiveCollab
  class Client
    include HTTParty

    include ActiveCollab::Client::Account

    attr_reader :username
    attr_reader :current_user
    attr_reader :cookie
    attr_reader :modhash

    attr_accessor :api_endpoint
    attr_accessor :user_agent

    API_VERSION = 1
    API_URL_DEFAULT = 'https://app.activecollab.com/'

    def initialize(hostname = nil)
      @api_url = hostname

      self.class.base_uri api_url
    end

    def get(path, params = {})
      self.class.get("/api/v#{API_VERSION}#{path}", params)
    end

    def post(path, params = {})
      self.class.post("/api/v#{API_VERSION}#{path}", params)
    end

    def api_url
      @api_url ||= API_URL_DEFAULT
    end

    def user_agent
      @user_agent ||= "ActiveCollab #{ActiveCollab::VERSION.to_s}"
    end

  end
end
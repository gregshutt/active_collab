require 'httparty'

require 'active_collab/client/account'

module ActiveCollab
  class Client
    include ActiveCollab::Client::Account

    attr_reader :username
    attr_reader :current_user
    attr_reader :cookie
    attr_reader :modhash

    attr_accessor :api_endpoint
    attr_accessor :user_agent

    def initialize(username = nil, password = nil)
      @username = username
      @password = password

      sign_in(username, password) unless username.nil? || password.nil?
    end

    def api_endpoint
      @api_endpoint ||= 'https://app.activecollab.com/'
    end

    def user_agent
      @user_agent ||= "ActiveCollab #{ActiveCollab::Version.to_s}"
    end
  end
end
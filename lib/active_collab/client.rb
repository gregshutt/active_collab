require 'faraday'

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
    attr_accessor :middleware

    API_VERSION = 1
    API_URL_DEFAULT = 'https://app.activecollab.com/'

    def initialize(hostname = nil)
      @api_url = hostname
    end

    def api_url
      @api_url ||= API_URL_DEFAULT
    end

    def user_agent
      @user_agent ||= "ActiveCollab #{ActiveCollab::VERSION.to_s}"
    end

    def middleware
      @middleware ||= Faraday::RackBuilder.new do |builder|
        builder.use Faraday::Request::UrlEncoded
        #builder.use RedditKit::Response::RaiseError
        #builder.use RedditKit::Response::ParseJSON
        builder.adapter Faraday.default_adapter
      end
    end

    private
      def get(path, params = {})
        request(:get, build_url(path), params, connection)
      end

      def post(path, params = {})
        request(:post, build_url(path), params, connection)
      end

      def request(method, path, parameters = {}, request_connection)
        request_connection.send(method.to_sym, path, parameters)
      rescue Faraday::Error::ClientError
        raise 'oh noes'
      end
    
      def connection
        @connection ||= connection_with_url(api_url)
      end

      def connection_with_url(url)
        Faraday.new url, builder: middleware
      end

      def build_url(path)
        "/api/v#{API_VERSION}#{path}"
      end
  end
end
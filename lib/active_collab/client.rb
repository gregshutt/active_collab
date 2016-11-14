require 'faraday'

require 'active_collab/client/account'
require 'active_collab/client/companies'
require 'active_collab/client/discussions'
require 'active_collab/client/projects'
require 'active_collab/client/task_lists'
require 'active_collab/client/tasks'
require 'active_collab/client/users'
require 'active_collab/response/parse_json'
require 'active_collab/response/raise_error'

module ActiveCollab
  class Client
    include ActiveCollab::Client::Account
    include ActiveCollab::Client::Companies
    include ActiveCollab::Client::Discussions
    include ActiveCollab::Client::Projects
    include ActiveCollab::Client::TaskLists
    include ActiveCollab::Client::Tasks
    include ActiveCollab::Client::Users

    attr_reader :username
    attr_reader :current_user
    attr_reader :token

    attr_accessor :api_endpoint
    attr_accessor :user_agent
    attr_accessor :middleware

    API_VERSION = 1

    def initialize(username = nil, password = nil)
      username ||= ActiveCollab.configuration.username
      password ||= ActiveCollab.configuration.password

      if (! username.nil?) && (! password.nil?)
        sign_in(username, password)
      end
    end

    def api_endpoint
      @api_endpoint ||= ActiveCollab.configuration.api_endpoint
    end

    def user_agent
      @user_agent ||= "ActiveCollab #{ActiveCollab::VERSION.to_s}"
    end

    def middleware
      @middleware ||= Faraday::RackBuilder.new do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use ActiveCollab::Response::RaiseError
        builder.use ActiveCollab::Response::ParseJSON
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

      def put(path, params = {})
        request(:put, build_url(path), params, connection)
      end

      def request(method, path, parameters = {}, request_connection)
        if signed_in?
          request = proc do |request|
            request.headers['X-Angie-AuthApiToken'] = @token
          end

          request_connection.send(method.to_sym, path, parameters, &request).env
        else
          request_connection.send(method.to_sym, path, parameters).env
        end
      rescue Faraday::Error::ClientError
        raise 'oh noes'
      end
    
      def connection
        @connection ||= connection_with_url(api_endpoint)
      end

      def connection_with_url(url)
        Faraday.new url, builder: middleware
      end

      def build_url(path)
        "/api/v#{API_VERSION}#{path}"
      end
  end
end
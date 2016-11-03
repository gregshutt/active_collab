module ActiveCollab
  class Client

    module Account

      # Sign in to an ActiveCollab account.
      #
      # @see https://developers.activecollab.com/api-documentation/v1/authentication.html
      # @param username [String] The ActiveCollab account's username.
      # @param password [String] The ActiveCollab account's password.
      def sign_in(username, password)
        response = post '/issue-token', { 
          username: username, 
          password: password,
          client_name: user_agent,
          client_vendor: 'Independence Software, Inc'
        }
        #body = response[:body]

        #data = body[:json][:data]

        #@modhash = data[:modhash]
        #@cookie = data[:cookie]
        #@username = username

        #@current_user = user @username
        #@username = @current_user.username
      end

      # Check is a user is currently signed in.
      #
      # @return [Boolean]
      def signed_in?
        !!@modhash and !!@cookie
      end

      # Sign the current user out.
      def sign_out
        @username = nil
        @current_user = nil

        @modhash = nil
        @cookie = nil
      end


    end
  end
end
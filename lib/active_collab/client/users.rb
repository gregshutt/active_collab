require 'active_collab/user'

module ActiveCollab
  class Client

    module Users

      # Gets a user's ID and status from their email addresss.
      #
      # @see https://developers.activecollab.com/api-documentation/v1/people/users/validate-email-address.html
      # @param username [String] The ActiveCollab account's email address.
      def user(email = nil)
        # cache the current user
        if email.nil? && @current_user
          return @current_user
        end

        # get all the active users
        response = get '/users'

        body = response[:body]

        email = @username if email.nil?

        user = body.find do |user|
          email == user[:email]
        end

        if user.nil?
          return nil
        end

        User.new(self, user)
      end
    end
  end
end
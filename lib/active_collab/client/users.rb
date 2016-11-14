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

      def save_user(user)
        # set the company id
        if user.company_id.nil?
          user.company_id = ActiveCollab.configuration.company_id
        end

        # get all the active projects
        response = post "/users", user.field_attributes

        body = response[:body]
        User.new(self, body[:single])
      end

      def invite(email_addresses, role, project_ids)
        response = post("/users/invite", {
          email_addresses: email_addresses,
          role: role,
          project_ids: project_ids
        })
      end
    end
  end
end
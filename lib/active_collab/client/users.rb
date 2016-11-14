require 'active_collab/user'
require 'active_collab/user_invitation'

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

      def invite_user(email_addresses, role, project_ids)
        if ! email_addresses.is_a? Array
          email_addresses = [email_addresses]
        end

        if ! project_ids.is_a? Array
          project_ids = [project_ids]
        end

        response = post("/users/invite", {
          email_addresses: email_addresses,
          role: role,
          project_ids: project_ids
        })

        body = response[:body]
        body.map { |b| User.new(self, b) }
      end

      def resend_invitation(user)
        response = put("/users/#{user.id}/resend-invitation")

        body = response[:body]
        UserInvitation.new(self, body[:single])
      end
    end
  end
end
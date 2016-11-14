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

      def save_user(user, new_fields = nil)
        # set the company id
        if user.company_id.nil?
          user.company_id = ActiveCollab.configuration.company_id
        end

        # get all the active projects
        if user.id.nil?
          response = post "/users", user.field_attributes
        else
          response = put "/users/#{user.id}", new_fields || user.field_attributes
        end

        body = response[:body]
        User.new(self, body[:single])
      end

      def invite_user(email_addresses, role, project_ids, company_id = nil)
        if ! email_addresses.is_a? Array
          email_addresses = [email_addresses]
        end

        if ! project_ids.is_a? Array
          project_ids = [project_ids]
        end

        if company_id.nil?
          company_id = ActiveCollab.configuration.company_id
        end

        response = post("/users/invite", {
          email_addresses: email_addresses,
          role: role,
          project_ids: project_ids,
          company_id: company_id
        })

        body = response[:body]
        body.map { |b| User.new(self, b) }
      end

      def resend_invitation(user)
        response = put("/users/#{user.id}/resend-invitation")

        body = response[:body]
        UserInvitation.new(self, body[:single].merge({user_id: user.id}))
      end

      def accept_invitation(user_invitation, user)
        response = post("/accept-invitation?user_id=#{user_invitation.user_id}&code=#{user_invitation.code}",
          user.field_attributes)


      end
    end
  end
end
require 'spec_helper'

describe ActiveCollab::Client::Users, :vcr do
  before do
    ActiveCollab.reset
    ActiveCollab.configure do |config|
      config.api_endpoint = activecollab_host
      config.username = activecollab_username
      config.password = activecollab_password
      config.company_id = 1
    end
  end

  describe "#user" do
    it "returns a valid user for the signed in email" do
      client = ActiveCollab::Client.new
      
      user = client.user

      expect(client.signed_in?).to be true
      expect(user).not_to be_nil
      expect(user).to be_a_kind_of(ActiveCollab::User)
    end

    it "creates a new user" do
      client = ActiveCollab::Client.new

      user = ActiveCollab::User.new(client)
      user.type = 'Client'
      user.email = 'test-client@example.com'
      user.password = 'abc'
      user.first_name = 'Skip'
      user.last_name = 'Gaily'
      user.save
    end

    it "invites users" do
      client = ActiveCollab::Client.new

      client.invite_user('testguy@example.com', 'Client', 16)
    end

    it "resends and accepts invitations" do
      client = ActiveCollab::Client.new

      user = ActiveCollab::User.new(client, id: 63)
      user_invitation = client.resend_invitation(user)

      expect(user_invitation.code).not_to be_nil

      # make sure it merges the user id
      expect(user_invitation.user_id).to eq 63

      client.accept_invitation(user_invitation, ActiveCollab::User.new(client, {
        first_name: 'Test', last_name: 'Guy', password: 'abc', language_id: '1'
      }))
    end
  end

end
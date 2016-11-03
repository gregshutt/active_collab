require 'spec_helper'

describe ActiveCollab::Client::Users, :vcr do

  describe "#user" do
    it "returns a valid user for the signed in email" do
      client = ActiveCollab::Client.new activecollab_host, activecollab_username, activecollab_password
      
      user = client.user

      expect(client.signed_in?).to be true
      expect(user).not_to be_nil
      expect(user).to be_a_kind_of(ActiveCollab::User)
    end
  end

end
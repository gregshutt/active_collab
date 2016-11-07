require 'spec_helper'

describe ActiveCollab::Client::Users, :vcr do
  before do
    ActiveCollab.reset
    ActiveCollab.configure do |config|
      config.api_endpoint = activecollab_host
      config.username = activecollab_username
      config.password = activecollab_password
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
  end

end
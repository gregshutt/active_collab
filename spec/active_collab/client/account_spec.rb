require 'spec_helper'

describe ActiveCollab::Client::Account, :vcr do

  describe "#sign_in" do
    it "signs the user in" do
      client = ActiveCollab::Client.new activecollab_host
      client.sign_in(activecollab_username, activecollab_password)

      expect(client.signed_in?).to be true
    end
  end

  describe "#sign_out" do
    it "signs the current user out" do
      #client = RedditKit::Client.new :username => redditkit_username, :password => redditkit_password
      #client.sign_out

      #expect(client.signed_in?).to be false
    end
  end

end
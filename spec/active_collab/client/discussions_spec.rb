require 'spec_helper'

describe ActiveCollab::Client::Discussions, :vcr do
  before do
    ActiveCollab.reset
    ActiveCollab.configure do |config|
      config.api_endpoint = activecollab_host
      config.username = activecollab_username
      config.password = activecollab_password
    end
  end

  describe "#discussions" do
    it "saves a new discussion" do
      client = ActiveCollab::Client.new
      
      discussion = ActiveCollab::Discussion.new(client)
      discussion.name = 'Test task'
      discussion.body = 'Need to do stuff'
      discussion.project_id = 16
      discussion.subscribers = [ 1 ]

      discussion = discussion.save

      # should have assigned a new id
      expect(discussion.id).not_to be_nil
      expect(discussion.body).to eq 'Need to do stuff'
    end

    
  end

end
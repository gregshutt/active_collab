require 'spec_helper'

describe ActiveCollab::Client::Projects, :vcr do

  describe "#projects" do
    it "returns all allowed projects" do
      client = ActiveCollab::Client.new activecollab_host, activecollab_username, activecollab_password
      
      projects = client.projects

      
    end
  end

end
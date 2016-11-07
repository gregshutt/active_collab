require 'spec_helper'

describe ActiveCollab::Client::Projects, :vcr do
  before do
    ActiveCollab.reset
    ActiveCollab.configure do |config|
      config.api_endpoint = activecollab_host
      config.username = activecollab_username
      config.password = activecollab_password
    end
  end

  describe "#projects" do
    it "returns all allowed projects" do
      client = ActiveCollab::Client.new activecollab_host, activecollab_username, activecollab_password
      
      projects = client.projects

      expect(projects.length).to eq 1
      expect(projects.first).to_not be nil
      expect(projects.first).to be_a_kind_of(ActiveCollab::Project)
      expect(projects.first.id).to eq 16
      expect(projects.first.url_path).to eq '/projects/16'
      expect(projects.first.email).to eq activecollab_support_email
      expect(projects.first.name).to eq 'Test Project'
    end
  end

end
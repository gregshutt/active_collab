require 'spec_helper'

describe ActiveCollab::Client::Companies, :vcr do
  before do
    ActiveCollab.reset
    ActiveCollab.configure do |config|
      config.api_endpoint = activecollab_host
      config.username = activecollab_username
      config.password = activecollab_password
    end
  end

  describe "#companies" do
    it "returns all allowed companies" do
      client = ActiveCollab::Client.new
      
      companies = client.companies

      expect(companies.length).to eq 1
      expect(companies.first).to_not be nil
      expect(companies.first).to be_a_kind_of(ActiveCollab::Company)
      expect(companies.first.id).to eq 1
    end

  end

end
require 'spec_helper'

describe ActiveCollab::Configuration do

  describe "#api_url" do
    it "defaults the api endpoint" do
      expect(ActiveCollab::Configuration.new.api_endpoint).to eq 'https://app.activecollab.com'
    end
  end

  describe "#api_url=" do
    it "can set the api endpoint" do
      config = ActiveCollab::Configuration.new
      config.api_endpoint = 'https://example.com'
      expect(config.api_endpoint).to eq 'https://example.com'
    end
  end

  describe "#company_id=" do
    it "can set the default company id" do
      config = ActiveCollab::Configuration.new
      config.company_id = 1
      expect(config.company_id).to eq 1
    end
  end

end
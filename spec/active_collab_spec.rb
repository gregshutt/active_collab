require "spec_helper"

describe ActiveCollab do
  it "has a version number" do
    expect(ActiveCollab::VERSION).not_to be nil
  end

  describe "#configure" do
    before do
      ActiveCollab.configure do |config|
        config.api_endpoint = 'https://example.com'
      end
    end

    it 'stores the configuration' do
      expect(ActiveCollab.configuration.api_endpoint).to eq 'https://example.com'
    end
  end
end

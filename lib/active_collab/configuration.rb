module ActiveCollab
  class Configuration
    attr_accessor :api_endpoint
    attr_accessor :username
    attr_accessor :password
    attr_accessor :company_id

    def initialize
      @api_endpoint = 'https://app.activecollab.com'
      @username = nil
      @password = nil
      @company_id = nil
    end
  end
end
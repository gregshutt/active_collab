module ActiveCollab
  class Configuration
    attr_accessor :api_endpoint
    attr_accessor :username
    attr_accessor :password

    def initialize
      @api_endpoint = 'https://app.activecollab.com'
      @username = ''
      @password = ''
    end
  end
end
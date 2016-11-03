require 'json'

module ActiveCollab
  class Error < StandardError
    class << self

      def from_status_code_and_body(status_code, body)
        return if status_code == 200

        case status_code
        when 200
          
        when 401
          raise AuthenticationRequired

        when 404
          raise EndpointNotFound
        end
      end

      private


    end
  end

  # Raised when there should be an authenticated user, but there isn't.
  class AuthenticationRequired < Error; end
  
  class EndpointNotFound < Error; end

end
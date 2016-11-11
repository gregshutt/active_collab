require 'active_collab/company'

module ActiveCollab
  class Client

    module Companies

      # Gets a list of all allowed companies.
      #
      # @see https://developers.activecollab.com/api-documentation/v1/people/companies/all.html
      def companies
        # get all the active projects
        response = get '/companies'

        body = response[:body]

        body.map { |c| Company.new(self, c) }
      end
    end
  end
end
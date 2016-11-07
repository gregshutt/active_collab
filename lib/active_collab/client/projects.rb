require 'active_collab/project'

module ActiveCollab
  class Client

    module Projects

      # Gets a list of all allowed projects.
      #
      # @see https://developers.activecollab.com/api-documentation/v1/projects/projects.html
      def projects()
        # get all the active projects
        response = get '/projects'

        body = response[:body]

        puts body.inspect
      end
    end
  end
end
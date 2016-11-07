require 'active_collab/project'

module ActiveCollab
  class Client

    module Projects

      # Gets a list of all allowed projects.
      #
      # @see https://developers.activecollab.com/api-documentation/v1/projects/projects.html
      def projects
        # get all the active projects
        response = get '/projects'

        body = response[:body]

        body.map { |b| Project.new b }
      end
    end
  end
end
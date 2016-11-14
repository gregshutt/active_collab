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

        body.map { |b| Project.new(self, b) }
      end

      def save_project(project)
        if project.id.nil?
          response = post "/projects", project.field_attributes
        else
          response = put "/projects/#{project.id}", project.field_attributes
        end

        body = response[:body]
        Project.new(self, body[:single])
      end
    end
  end
end
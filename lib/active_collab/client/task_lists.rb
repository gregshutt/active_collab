require 'active_collab/task_list'

module ActiveCollab
  class Client

    module TaskLists

      # Gets a list of all allowed projects.
      #
      # @see https://developers.activecollab.com/api-documentation/v1/projects/projects.html
      def task_lists(project_id)
        # get all the active projects
        response = get "/projects/#{project_id}/task-lists"

        body = response[:body]
        
        body.map { |b| TaskList.new(self, b) }
      end
    end
  end
end
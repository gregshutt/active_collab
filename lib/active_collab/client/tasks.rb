require 'active_collab/task'

module ActiveCollab
  class Client

    module Tasks

      def save_task(task)
        # get all the active projects
        response = post "/projects/#{task.project_id}/tasks", task.field_attributes

        body = response[:body]
        Task.new(self, body[:single])
      end
    end
  end
end
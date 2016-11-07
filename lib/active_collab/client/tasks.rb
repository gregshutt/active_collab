require 'active_collab/task'

module ActiveCollab
  class Client

    module Tasks

      def save_task(task)
        # get all the active projects
        response = post "/projects/#{task.project_id}/tasks", task.field_attributes

        body = response[:body]
        puts task.field_attributes.inspect
        puts body.inspect
      end
    end
  end
end
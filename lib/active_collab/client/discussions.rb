require 'active_collab/discussion'

module ActiveCollab
  class Client

    module Discussions

      def save_discussion(discussion)
        # get all the active projects
        response = post "/projects/#{discussion.project_id}/discussions", discussion.field_attributes

        body = response[:body]
        Discussion.new(self, body[:single])
      end
    end
  end
end
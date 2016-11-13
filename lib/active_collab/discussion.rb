require 'active_collab/base'

module ActiveCollab

  # A class representing an ActiveCollab user.
  class Discussion < ActiveCollab::Base

    attr_reader :id
    attr_reader :class
    attr_reader :url_path

    attr_accessor :name
    attr_accessor :body

    attr_accessor :project_id
    attr_accessor :subscribers

    def save
      self.client.save_discussion(self)
    end
  end
end
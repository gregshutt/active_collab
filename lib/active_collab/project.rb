require 'active_collab/base'

module ActiveCollab

  # A class representing an ActiveCollab user.
  class Project < ActiveCollab::Base

    attr_reader :id
    attr_reader :class
    attr_reader :url_path

    attr_reader :name
    attr_reader :email
    attr_accessor :members

    def task_lists
      self.client.task_lists(self.id)
    end

    def save
      self.client.save_discussion(self)
    end
  end
end
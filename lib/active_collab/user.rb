require 'active_collab/base'

module ActiveCollab

  # A class representing an ActiveCollab user.
  class User < ActiveCollab::Base

    attr_reader :id
    attr_reader :class
    attr_reader :url_path

    attr_accessor :is_archived, :is_trashed

    attr_accessor :company_id
    attr_accessor :type
    attr_accessor :email
    attr_accessor :password
    attr_accessor :first_name, :last_name
    attr_accessor :language_id

    def save
      self.client.save_user(self)
    end
  end
end
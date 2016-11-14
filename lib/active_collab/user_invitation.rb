require 'active_collab/base'

module ActiveCollab

  # A class representing an ActiveCollab user invitation.
  class UserInvitation < ActiveCollab::Base

    attr_reader :id
    attr_reader :class
    attr_reader :url_path

    attr_reader :code
    
    attr_accessor :user_id
  end
end
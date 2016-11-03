require 'active_collab/base'

module ActiveCollab

  # A class representing an ActiveCollab user.
  class User < ActiveCollab::Base

    attr_reader :id
    attr_reader :class
    attr_reader :url_path
  end
end
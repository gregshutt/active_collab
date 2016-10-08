require 'httparty'
require 'active_collab/version'
require 'active_collab/client'

module ActiveCollab

  @@api_url = nil

  def self.api_url=(api_url)
    @@api_url = api_url
  end

  def self.client
    ActiveCollab::Client.new(@@api_url) 
  end

end
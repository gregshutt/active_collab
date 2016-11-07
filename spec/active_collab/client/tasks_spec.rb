require 'spec_helper'

describe ActiveCollab::Client::Tasks, :vcr do
  before do
    ActiveCollab.reset
    ActiveCollab.configure do |config|
      config.api_endpoint = activecollab_host
      config.username = activecollab_username
      config.password = activecollab_password
    end
  end

  describe "#tasks" do
    it "saves a new task" do
      client = ActiveCollab::Client.new
      
      task = ActiveCollab::Task.new(client)
      task.name = 'Test task'
      task.project_id = 16
      task.task_list_id = 31
      task.subscribers = [ 1 ]
      #task.summary = 'Need to do stuff'
      task.save
    end

    
  end

end
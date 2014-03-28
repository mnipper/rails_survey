class Export < ActiveRecord::Base
  attr_accessible :status, :download_url, :project_id 
  belongs_to :project
  
end

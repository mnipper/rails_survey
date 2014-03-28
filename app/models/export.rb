class Export < ActiveRecord::Base
  attr_accessible :done, :download_url, :project_id 
  belongs_to :project

end

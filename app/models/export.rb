class Export < ActiveRecord::Base
  attr_accessible :done, :download_url, :project_id, :instrument_id 
  belongs_to :project
  belongs_to :instrument
end

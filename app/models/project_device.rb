class ProjectDevice < ActiveRecord::Base
  attr_accessible :device_id, :project_id
  belongs_to :project
  belongs_to :device
  validates :device_id, presence: true, allow_blank: false
  validates :project_id, presence: true, allow_blank: false
end

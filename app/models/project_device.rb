class ProjectDevice < ActiveRecord::Base
  attr_accessible :device_id, :project_id
  has_many :projects
  has_many :devices
  validates :device_id, presence: true, allow_blank: false
  validates :project_id, presence: true, allow_blank: false
end

class UserProject < ActiveRecord::Base
  attr_accessible :user_id, :project_id
  belongs_to :project
  belongs_to :user
  validates :user_id, presence: true, allow_blank: false
  validates :project_id, presence: true, allow_blank: false
end

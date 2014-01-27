# == Schema Information
#
# Table name: user_projects
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserProject < ActiveRecord::Base
  attr_accessible :user_id, :project_id
  belongs_to :project
  belongs_to :user
  validates :user_id, presence: true, allow_blank: false
  validates :project_id, presence: true, allow_blank: false
end

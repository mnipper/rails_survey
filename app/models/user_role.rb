class UserRole < ActiveRecord::Base
  attr_accessible :user_id, :role_id
  belongs_to :user
  belongs_to :role
  validates :user_id, presence: true, allow_blank: false
  validates :role_id, presence: true, allow_blank: false
end

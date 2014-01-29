class Role < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true, allow_blank: false
  has_many :user_roles
  has_many :users, through: :user_roles
end

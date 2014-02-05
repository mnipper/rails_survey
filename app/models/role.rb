class Role < ActiveRecord::Base
  attr_accessible :name, :user_id 
  validates :name, presence: true, allow_blank: false
  belongs_to :user
end

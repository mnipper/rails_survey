class Project < ActiveRecord::Base

  attr_accessible :name, :description
  has_many :instruments
  has_many :users
  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: true

end

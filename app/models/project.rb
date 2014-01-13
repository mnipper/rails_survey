class Project < ActiveRecord::Base

  attr_accessible :name, :description
  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: true

end

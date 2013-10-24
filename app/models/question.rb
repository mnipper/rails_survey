class Question < ActiveRecord::Base
  belongs_to :instrument
  has_many :options
  accepts_nested_attributes_for :options
end

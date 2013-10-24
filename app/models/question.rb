class Question < ActiveRecord::Base
  belongs_to :instrument
  has_many :options
end

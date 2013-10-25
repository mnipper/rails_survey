class Survey < ActiveRecord::Base
  belongs_to :instrument
  has_many :responses
end

class Instrument < ActiveRecord::Base
  has_many :questions
end

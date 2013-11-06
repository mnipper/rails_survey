class Instrument < ActiveRecord::Base
  has_many :questions
  has_many :surveys
  accepts_nested_attributes_for :questions, allow_destroy: true

end

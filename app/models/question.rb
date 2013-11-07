class Question < ActiveRecord::Base
  belongs_to :instrument
  has_many :responses
  has_many :options
  accepts_nested_attributes_for :options, allow_destroy: true

  def response_count
    self.responses.count
  end
end

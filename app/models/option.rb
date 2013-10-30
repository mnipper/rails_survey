class Option < ActiveRecord::Base
  belongs_to :question

  def to_s
    text
  end
end

# == Schema Information
#
# Table name: options
#
#  id                 :integer          not null, primary key
#  question_id        :integer
#  text               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  next_question      :string(255)
#  number_in_question :integer
#

class Option < ActiveRecord::Base
  include Translatable
  attr_accessible :question_id, :text, :next_question, :number_in_question
  belongs_to :question
  delegate :instrument, to: :question
  delegate :project, to: :question
  has_many :translations, foreign_key: 'option_id', class_name: 'OptionTranslation', dependent: :destroy
  has_paper_trail

  validates :text, presence: true, allow_blank: false

  def to_s
    text
  end

  def version_at_time(time)
    self.version_at(time + 1)
  end

end

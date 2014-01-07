# == Schema Information
#
# Table name: options
#
#  id            :integer          not null, primary key
#  question_id   :integer
#  text          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  next_question :string(255)
#

class Option < ActiveRecord::Base
  include Translatable
  attr_accessible :question_id, :text, :next_question
  belongs_to :question
  has_many :translations, foreign_key: 'option_id', class_name: 'OptionTranslation', dependent: :destroy
  has_paper_trail

  validates :text, presence: true, allow_blank: false

  has_many :option_associations
  after_save :update_version_associations

  def to_s
    text
  end

  def option_version(qst_version)
    v_number = 0
    version = option_associations.where("question_id = ? AND question_version = ? AND option_id = ?", question.id, qst_version, self.id)
    version.each do |v|
      v_number = v.option_version
    end
    if v_number == (self.versions.length - 1)
      self
    else
      self.versions[v_number + 1].reify
    end
  end

  private
  def update_version_associations
    OptionAssociation.create(:question_id => question.id, :option_id => self.id, :question_version => question.current_version_number, :option_version => (self.versions.count - 1))
  end

end

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
  has_many :option_associations, dependent: :destroy
  after_save :update_version_associations
  has_paper_trail

  validates :text, presence: true, allow_blank: false

  def to_s
    text
  end

  def option_version(qst_version, inst_version)
    option_version_number = (self.versions.count - 1)
    version_relation = option_associations.where("instrument_version = ? AND option_id = ?", inst_version, self.id) #TODO Question version changes though question text might not be changed
    version_relation.each do |ver|
      option_version_number = ver.option_version
    end
    if version_relation.empty?
      puts "EMPTY"
    end
    if option_version_number == (self.versions.length - 1)
      self
    else
      self.versions[option_version_number+1].reify
    end
  end

  private
  def update_version_associations
    version_number = (self.versions.count - 1)
    inst_version = question.instrument.current_version_number
    OptionAssociation.create(:question_id => question.id, :option_id => self.id, :question_version => question.current_version_number,
                             :option_version => version_number, :instrument_version => inst_version, :instrument_id => question.instrument_id)
  end

end

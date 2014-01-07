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
 # before_save :update_parent_count

  def to_s
    text
  end

  def option_version(qst_version, inst_version)
    v_number = 0
    puts "THERE SHOULD BE TWO"
    puts inst_version
    puts question.instrument_id
    version_num = OptionAssociation.where("question_version = ? AND instrument_version = ?", qst_version, (inst_version-1))
    puts "START"
    version_num.each do |v|
      puts "ENTER"
      v_number = v.option_version
      puts "version #"
      puts v_number
    end
    puts "DONE"
    if version_num.empty?
      puts "EMPTY"
    end
    if v_number == (self.versions.length - 1)
      puts "SAME"
      puts v_number
      self
    else
      puts "VERSIONED"
      puts v_number
      self.versions[v_number-1].reify
    end
  end

  private
  def update_version_associations
    version_number = (self.versions.count - 1)
    inst_version = question.instrument.child_update_count
    OptionAssociation.create(:question_id => question.id, :option_id => self.id, :question_version => question.current_version_number,
                             :option_version => version_number, :instrument_version => inst_version, :instrument_id => question.instrument_id)
  end

  def update_parent_count

  end

end

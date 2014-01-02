# == Schema Information
#
# Table name: questions
#
#  id                               :integer          not null, primary key
#  text                             :string(255)
#  question_type                    :string(255)
#  question_identifier              :string(255)
#  instrument_id                    :integer
#  created_at                       :datetime
#  updated_at                       :datetime
#  following_up_question_identifier :string(255)
#  reg_ex_validation                :string(255)
#

class Question < ActiveRecord::Base
  include Translatable
  attr_accessible :text, :question_type, :question_identifier, :instrument_id,
          :options_attributes, :following_up_question_identifier, :reg_ex_validation
  belongs_to :instrument
  has_many :responses
  has_many :options, dependent: :destroy
  has_many :translations, foreign_key: 'question_id', class_name: 'QuestionTranslation', dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true
  before_save :parent_update_count
  has_paper_trail

  validates :question_identifier, uniqueness: true, presence: true, allow_blank: false
  validates :text, presence: true, allow_blank: false

  def has_options?
    !options.empty?
  end

  def option_count
    options.count
  end

  def as_json(options={})
    super((options || {}).merge({
        methods: [:option_count]
    }))
  end

  private
  def parent_update_count
    instrument.increment!(:child_update_count) unless self.new_record?
  end
end

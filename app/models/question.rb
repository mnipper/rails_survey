# == Schema Information
#
# Table name: questions
#
#  id                               :integer          not null, primary key
#  text                             :text
#  question_type                    :string(255)
#  question_identifier              :string(255)
#  instrument_id                    :integer
#  created_at                       :datetime
#  updated_at                       :datetime
#  following_up_question_identifier :string(255)
#  reg_ex_validation                :string(255)
#  number_in_instrument             :integer
#  reg_ex_validation_message        :string(255)
#  follow_up_position               :integer          default(0)
#  deleted_at                       :datetime
#  identifies_survey                :boolean          default(FALSE)
#  instructions                     :text             default("")
#

class Question < ActiveRecord::Base
  include Translatable
  default_scope { order('number_in_instrument ASC') }
  attr_accessible :text, :question_type, :question_identifier, :instrument_id,
          :following_up_question_identifier, :reg_ex_validation,
          :number_in_instrument, :reg_ex_validation_message, :identifies_survey,
          :instructions
  belongs_to :instrument
  has_many :responses
  has_many :options, dependent: :destroy
  has_many :translations, foreign_key: 'question_id', class_name: 'QuestionTranslation', dependent: :destroy
  has_many :images, dependent: :destroy  
  delegate :project, to: :instrument
  before_save :update_instrument_version, if: Proc.new { |question| question.changed? }
  before_destroy :update_instrument_version
  has_paper_trail
  acts_as_paranoid

  validates :question_identifier, uniqueness: true, presence: true, allow_blank: false
  validates :text, presence: true, allow_blank: false
  validates :number_in_instrument, presence: true, allow_blank: false

  amoeba do
    enable
    include_field :options
    include_field :translations
    nullify :following_up_question_identifier
    set :follow_up_position => 0
  end

  def has_options?
    !options.empty?
  end

  def option_count
    options.count
  end
  
  def image_count
    images.count
  end

  def instrument_version
    instrument.current_version_number
  end

  def as_json(options={})
    super((options || {}).merge({
        methods: [:option_count, :instrument_version, :image_count]
    }))
  end

  def has_other?
    Settings.question_with_options.include? question_type
  end

  def other_index
    options.length
  end

  private
  def update_instrument_version
    instrument.update_instrument_version
  end
end

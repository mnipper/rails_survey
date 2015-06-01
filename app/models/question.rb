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
#  deleted_at                       :datetime
#  follow_up_position               :integer          default(0)
#  identifies_survey                :boolean          default(FALSE)
#  instructions                     :text             default("")
#  child_update_count               :integer          default(0)
#  grid_id                          :integer
#  first_in_grid                    :boolean          default(FALSE)
#  instrument_version_number        :integer          default(-1)
#

class Question < ActiveRecord::Base
  include Translatable
  default_scope { order('number_in_instrument ASC') }
  attr_accessible :text, :question_type, :question_identifier, :instrument_id, :follow_up_position,
          :following_up_question_identifier, :reg_ex_validation, :child_update_count,
          :number_in_instrument, :reg_ex_validation_message, :identifies_survey,
          :instructions, :grid_id, :first_in_grid, :instrument_version_number
  belongs_to :instrument
  belongs_to :grid 
  has_many :responses
  has_many :options, dependent: :destroy
  has_many :translations, foreign_key: 'question_id', class_name: 'QuestionTranslation', dependent: :destroy
  has_many :images, dependent: :destroy  
  delegate :project, to: :instrument
  before_save :update_instrument_version, if: Proc.new { |question| question.changed? and !question.child_update_count_changed? }
  before_save :update_question_translation, if: Proc.new { |question| question.text_changed? }
  before_save :update_first_in_grid, if: Proc.new { |question| question.first_in_grid_changed? }
  after_save :record_instrument_version
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
    nullify :instrument_id
    nullify :number_in_instrument
    nullify :question_identifier
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
    read_attribute(:instrument_version_number) == -1 ? instrument.current_version_number : read_attribute(:instrument_version_number)
  end

  def as_json(options={})
    super((options || {}).merge({
        methods: [:option_count, :instrument_version, :image_count, :question_version]
    }))
  end

  def has_other?
    Settings.question_with_other.include? question_type
  end

  def other_index
    options.length
  end

  def update_question_translation(status = true)
    translations.each do |translation|
      translation.update_attribute(:question_changed, status)
    end
  end

  def update_question_version
    # Force update for paper trail
    increment!(:child_update_count)
  end

  def question_version
    versions.count
  end
  
  def starts_section
    Section.find_by_start_question_identifier(self.question_identifier)
  end

  def select_one_variant?
    self.question_type == "SELECT_ONE" or self.question_type == "SELECT_ONE_WRITE_OTHER"
  end
  
  def select_multiple_variant?
    self.question_type == "SELECT_MULTIPLE" or self.question_type == "SELECT_MULTIPLE_WRITE_OTHER"
  end

  def update_first_in_grid
    if first_in_grid
      questions_in_grid = Question.where("grid_id = ?", grid_id)
      questions_in_grid.where.not(id: id).each do |question|
        question.update_attribute(:first_in_grid, false)
      end
    end
  end
  
  private
  def update_instrument_version
    instrument.update_instrument_version 
  end
  
  def record_instrument_version
    update_column(:instrument_version_number, instrument_version)
  end
end

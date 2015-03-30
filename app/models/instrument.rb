# == Schema Information
#
# Table name: instruments
#
#  id                      :integer          not null, primary key
#  title                   :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  language                :string(255)
#  alignment               :string(255)
#  child_update_count      :integer          default(0)
#  previous_question_count :integer
#  project_id              :integer
#  published               :boolean
#  deleted_at              :datetime
#  show_instructions       :boolean          default(FALSE)
#

class Instrument < ActiveRecord::Base
  include Translatable
  include Alignable
  include LanguageAssignable
  scope :published, -> { where(published: true) }

  attr_accessible :title, :language, :alignment, :previous_question_count, :child_update_count,
      :published, :show_instructions, :project_id 
  belongs_to :project
  has_many :questions, dependent: :destroy
  has_many :surveys
  has_many :responses, through: :surveys
  has_many :response_images, through: :responses
  has_many :translations, foreign_key: 'instrument_id', class_name: 'InstrumentTranslation', dependent: :destroy
  has_many :response_exports 
  has_many :sections
  has_many :rules, dependent: :destroy
  has_paper_trail :on => [:update, :destroy]
  acts_as_paranoid

  before_save :update_question_count

  validates :title, presence: true, allow_blank: false
  validates :project_id, presence: true, allow_blank: false

  def version_by_version_number(version_number)
    InstrumentVersion.build(
      instrument_id: id,
      version_number: version_number
    )
  end

  def completion_rate
    sum = 0.0
    self.surveys.each do |survey|
        sum += survey.percent_complete
    end
    (sum / self.surveys.count).round(2)
  end

  def current_version_number
    versions.count
  end

  def question_count
    questions.count
  end

  def as_json(options={})
    super((options || {}).merge({
        methods: [:current_version_number, :question_count]
    }))
  end
  
  def survey_instrument_versions
    surveys.pluck(:instrument_version_number).uniq
  end

  def to_csv
    CSV.generate do |csv|
      export(csv)
    end
  end

  def export(format)   
    format << ['Instrument id:', id]
    format << ['Instrument title:', title]
    format << ['Version number:', current_version_number]
    format << ['Language:', language]
    format << ["\n"]
    format << ['number_in_instrument', 'question_identifier', 'question_type', 'question_instructions', 'question_text'] + instrument_translation_languages
    questions.each do |question|
      format << [question.number_in_instrument, question.question_identifier, question.question_type, 
        Sanitize.fragment(question.instructions), Sanitize.fragment(question.text)] + translations_for_object(question) 
      question.options.each {
        |option| format << ['', '', '', "Option for question #{question.question_identifier}", option.text] + translations_for_object(option) 
        if option.next_question
          format << ['', '', '', "For option #{option}, SKIP TO question", option.next_question]
        end
        if option.skips
          option.skips.each {
            |skip| format << ['', '', '', "For option #{option.text}, SKIP question", skip.question_identifier]
          }
        end
      }
      if question.reg_ex_validation_message
        format << ['', '', '', "Regular expression failure message for #{question.question_identifier}",
          question.reg_ex_validation_message]
      end
      if question.following_up_question_identifier
        format << ['','', '', "Following up on question", question.following_up_question_identifier]
        format << ['', '', '', "Follow up position", question.follow_up_position]
      end
      if question.identifies_survey
        format << ['', '', '', "Question identifies survey", "YES"]
      end
    end
  end
  
  def instrument_translation_languages
    translation_languages = []
    translations.each do |t_language|
      translation_languages << t_language.language
    end
    translation_languages 
  end
  
  def translations_for_object(obj) 
    text_translations = []
    obj.translations.each do |translation|
      if (instrument_translation_languages.include? translation.language)
        text_translations << Sanitize.fragment(translation.text)
      end
    end
    text_translations
  end

  def update_instrument_version
    # Force update for paper trail
    increment!(:child_update_count)
  end

  def reorder_questions(old_number, new_number)
    ActiveRecord::Base.transaction do
      # If question is moved up in instrument, settle conflicts by giving the
      # most recently updated (ie the moved question) the lower number.
      question_moved_up = old_number > new_number
      secondary_order = question_moved_up ? 'DESC' : 'ASC'

      questions.unscoped.where('instrument_id = ? AND deleted_at is null', self.id).order("number_in_instrument ASC, updated_at #{secondary_order}").each_with_index do |question, index|
        updated_number = index + 1
        if question.number_in_instrument != updated_number
          question.number_in_instrument = updated_number
          question.save
        end
      end
    end
  end

  def reorder_questions_after_delete(question_number)
    ActiveRecord::Base.transaction do
      questions.unscoped.where('instrument_id = ? AND number_in_instrument >= ? AND deleted_at is null', self.id, question_number).each_with_index do |question, index|
        question.number_in_instrument = question.number_in_instrument - 1
        question.save
      end
    end
  end

  private
  def update_question_count
    self.previous_question_count = questions.count
  end
end

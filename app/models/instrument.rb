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
#

class Instrument < ActiveRecord::Base
  include Translatable
  include Alignable
  include LanguageAssignable
  scope :published, -> { where(published: true) }

  attr_accessible :title, :language, :alignment, :previous_question_count, :child_update_count,
      :published
  belongs_to :project
  has_many :questions, dependent: :destroy
  has_many :surveys
  has_many :responses, through: :surveys
  has_many :translations, foreign_key: 'instrument_id', class_name: 'InstrumentTranslation', dependent: :destroy
  has_paper_trail :on => [:update, :destroy]
  acts_as_paranoid

  before_save :update_question_count

  validates :title, presence: true, allow_blank: false
  validates :project_id, presence: true, allow_blank: false

  def version(version_number)
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

  def to_csv
    CSV.generate do |csv|
      export(csv)
    end
  end

  def export(format)
    format << ['Instrument id:', id]
    format << ['Instrument title:', title]
    format << ['Version number:', current_version_number]
    format << ["\n"]
    format << ['number', 'qid', language]
    questions.each do |question|
      format << [question.number_in_instrument, question.question_identifier, question.text]
      question.options.each {|option| format << ['', "Option for #{question.question_identifier}", option.text]}
      if question.reg_ex_validation_message
        format << ['', "Regular expiression failure message for #{question.question_identifier}",
          question.reg_ex_validation_message]
      end
    end
  end

  def update_instrument_version
    # Force update for paper trail
    increment!(:child_update_count)
  end

  private
  def update_question_count
    self.previous_question_count = questions.count
  end
end

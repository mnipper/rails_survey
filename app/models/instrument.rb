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

  attr_accessible :title, :language, :alignment, :questions_attributes, :previous_question_count, :child_update_count,
      :published
  belongs_to :project
  has_many :questions, dependent: :destroy
  has_many :surveys
  has_many :translations, foreign_key: 'instrument_id', class_name: 'InstrumentTranslation', dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true
  has_paper_trail :on => [:update, :destroy]
  acts_as_paranoid

  before_save :update_question_count

  validates :title, presence: true, allow_blank: false
  validates :project_id, presence: true, allow_blank: false

  def self.instrument_response_count
    @response_map = []
    Instrument.all.each do |instrument|
      instrument.questions.each do |question|
        @response_map << {instrument.title => question.responses.count }
      end
    end
    @response_map
  end

  def completion_rate
    sum = 0.0
    self.surveys.each do |survey|
        sum += survey.percent_complete
    end
    (sum / self.surveys.count).round(2)
  end

  def response_count_per_day
    questions = self.questions.all
    responses = []
    questions.each do |question|
      responses << question.responses.select('DATE(created_at)').count(:group => 'DATE(created_at)')
    end
    responses.inject{|result, element| result.merge( element ){|k, old_v, new_v| old_v + new_v}}
  end

  def current_version_number
    versions.count
  end

  def question_count
    questions.count
  end

  def is_version?(version_number)
    current_version_number == version_number 
  end

  def question_count_for_version(version, number)
    count = 0
    time_at_version = self.versions[number].created_at 
    all_questions = version.reify.questions.with_deleted
    filtered_qst = all_questions.where("created_at < ?", time_at_version)
    filtered_qst.each do |question|
      if question.deleted_at
        count += 1 if question.deleted_at > time_at_version 
      else
        count += 1
      end
    end
    count
  end

  def as_json(options={})
    super((options || {}).merge({
        methods: [:current_version_number, :question_count]
    }))
  end

  private
  def update_question_count
    self.previous_question_count = questions.count
  end
end

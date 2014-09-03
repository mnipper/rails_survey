# == Schema Information
#
# Table name: options
#
#  id                 :integer          not null, primary key
#  question_id        :integer
#  text               :text
#  created_at         :datetime
#  updated_at         :datetime
#  next_question      :string(255)
#  number_in_question :integer
#  deleted_at         :datetime
#

class Option < ActiveRecord::Base
  include Translatable
  default_scope { order('number_in_question ASC') }
  attr_accessible :question_id, :text, :next_question, :number_in_question
  belongs_to :question
  delegate :instrument, to: :question
  delegate :project, to: :question
  has_many :translations, foreign_key: 'option_id', class_name: 'OptionTranslation', dependent: :destroy
  before_save :update_instrument_version, if: Proc.new { |option| option.changed? }
  before_save :update_option_translation, if: Proc.new { |option| option.text_changed? }
  before_destroy :update_instrument_version
  has_paper_trail
  acts_as_paranoid
  has_many :skips, dependent: :destroy 

  validates :text, presence: true, allow_blank: false

  amoeba do
    enable
    include_field :translations
    nullify :next_question 
  end

  def to_s
    text
  end

  def instrument_version
    instrument.current_version_number
  end

  def as_json(options={})
    super((options || {}).merge({
        methods: [:instrument_version]
    }))
  end

  def update_option_translation(status = true)
    translations.each do |translation|
      translation.update_attribute(:option_changed, status)
    end
  end
  
  private
  def update_instrument_version
    instrument.update_instrument_version
    question.update_question_version
  end
end

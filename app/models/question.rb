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
  has_many :question_associations
  accepts_nested_attributes_for :options, allow_destroy: true
  before_save :parent_update_count
  has_paper_trail

  validates :question_identifier, uniqueness: true, presence: true, allow_blank: false
  validates :text, presence: true, allow_blank: false

  after_save :check_version_number, :update_associations
  @previous_version_counter = 0

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

  def current_version_number
    versions.count
  end

  def is_version?(version_number)
    versions.count == version_number
  end

  def question_version(inst_version)
    v_number = 0
    version = question_associations.where("instrument_id = ? AND instrument_version = ? AND question_id = ?", instrument.id, inst_version, self.id)
    version.each do |v|
      v_number = v.question_version
      puts v_number
      puts inst_version
    end
    counts = self.versions.count
    puts counts
    puts "COUNTED"
    if counts < 2
      puts "NIL"
      self
    else
      puts "VERSION"
      puts self.versions.length
      self.versions[v_number].reify
    end
  end

  private
  def parent_update_count
    @previous_version_counter = instrument.current_version_number
    instrument.increment!(:child_update_count) unless self.new_record?
  end

  def check_version_number
    if @previous_version_counter == instrument.current_version_number
      instrument.increment!(:child_update_count)
    end
  end

  def update_associations
    version_number = self.versions.count
    if version_number > 0
      version_number = version_number - 1
    end
    QuestionAssociation.create(:instrument_id => instrument_id, :question_id => self.id, :instrument_version => instrument.current_version_number, :question_version => version_number)
  end

end

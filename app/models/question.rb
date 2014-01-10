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
  has_many :question_associations, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true
  before_save :parent_update_count
  after_save :update_associations#, :delete_extra_instrument_version
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

  def version_at_time(time)
    self.version_at(time + 1)
  end

  def question_version(inst_version)
    v_number = 0
    version = question_associations.where("instrument_id = ? AND instrument_version = ? AND question_id = ?", instrument.id, inst_version, self.id)
    version.each do |v|
      v_number = v.question_version
    end
    if v_number == (self.versions.length)
      puts "IF"
      self
    else
      if !self.versions[v_number].nil?
        puts "NOT NIL"
        self.versions[v_number].reify
      else
        puts "NIL"
        self
      end
    end
  end

  def current_version_number
    self.versions.count
  end

  def get_version_number(inst_version)
    version_number = 0
    version = question_associations.where("instrument_id = ? AND instrument_version = ? AND question_id = ?", instrument.id, inst_version, self.id)
    version.each do |v|
      version_number = v.question_version
    end
    version_number
  end

  private
  def parent_update_count
    instrument.increment!(:child_update_count) unless self.new_record?
  end

  def delete_extra_instrument_version
    if !self.options.empty?
      index = 0
      time_strings_array = []
      instrument.versions.each do |ver|
        time_string = ver.created_at.to_s
        if time_strings_array.include? time_string
          duplicate_version = instrument.versions[index]
          duplicate_version.destroy!
          break
        else
          time_strings_array << time_string
        end
        index += 1
      end
    end
  end

  def update_associations
    QuestionAssociation.create(:instrument_id => instrument.id, :question_id => self.id, :instrument_version => instrument.current_version_number, :question_version => self.versions.count)
  end

end

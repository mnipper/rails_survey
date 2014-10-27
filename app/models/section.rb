# == Schema Information
#
# Table name: sections
#
#  id                        :integer          not null, primary key
#  title                     :string(255)
#  start_question_identifier :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  instrument_id             :integer
#  deleted_at                :datetime
#

class Section < ActiveRecord::Base
  include Translatable
  attr_accessible :title, :start_question_identifier, :instrument_id 
  belongs_to :instrument 
  has_many :translations, foreign_key: 'section_id', class_name: 'SectionTranslation', dependent: :destroy
  before_save :update_instrument_version, if: Proc.new { |section| section.changed? }
  before_save :update_section_translation, if: Proc.new { |section| section.title_changed? }
  before_destroy :update_instrument_version
  acts_as_paranoid 
  validates :title, presence: true
  validates :start_question_identifier, presence: true
  
  def update_section_translation(status = true)
    translations.each do |translation|
      translation.update_attribute(:section_changed, status)
    end
  end
  
  private
  def update_instrument_version
    instrument.update_instrument_version
  end
  
end

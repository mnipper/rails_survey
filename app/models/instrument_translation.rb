# == Schema Information
#
# Table name: instrument_translations
#
#  id            :integer          not null, primary key
#  instrument_id :integer
#  language      :string(255)
#  alignment     :string(255)
#  title         :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class InstrumentTranslation < ActiveRecord::Base
  include Alignable
  include LanguageAssignable

  attr_accessible :title, :language, :alignment
  belongs_to :instrument
end

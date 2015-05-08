# == Schema Information
#
# Table name: surveys
#
#  id                        :integer          not null, primary key
#  instrument_id             :integer
#  created_at                :datetime
#  updated_at                :datetime
#  uuid                      :string(255)
#  device_id                 :integer
#  instrument_version_number :integer
#  instrument_title          :string(255)
#  device_uuid               :string(255)
#  latitude                  :string(255)
#  longitude                 :string(255)
#  metadata                  :text
#

class Survey < ActiveRecord::Base
  attr_accessible :instrument_id, :instrument_version_number, :uuid, :device_id, :instrument_title,
    :device_uuid, :latitude, :longitude, :metadata
  belongs_to :instrument
  belongs_to :device
  has_many :responses, foreign_key: :survey_uuid, primary_key: :uuid, dependent: :destroy
  delegate :project, to: :instrument
  
  validates :device_id, presence: true, allow_blank: false
  validates :uuid, presence: true, allow_blank: false
  validates :instrument_id, presence: true, allow_blank: false
  validates :instrument_version_number, presence: true, allow_blank: false
  
  def percent_complete
    (responses.where.not('text = ? AND other_response = ? AND special_response = ?', "", "", "")
    .pluck(:question_id).uniq.count.to_f / instrument.version_by_version_number(instrument_version_number).questions.count).round(2)
  end

  def location
    "#{latitude} / #{longitude}" if latitude and longitude
  end
  
  def group_responses_by_day
    self.responses.group_by_day(:created_at).count 
  end
  
  def group_responses_by_hour
    self.responses.group_by_hour_of_day(:created_at).count
  end

  def instrument_version
    instrument.version_by_version_number(instrument_version_number)
  end

  def location_link
    "https://www.google.com/maps/place/#{latitude}+#{longitude}" if latitude and longitude
  end

  def metadata
    JSON.parse(read_attribute(:metadata)) unless read_attribute(:metadata).nil?
  end
  
  def self.to_csv(csv_file, export_id)
    CSV.open(csv_file, "wb") do |csv|
      export(csv)
    end
    export = ResponseExport.find(export_id)
    export.update_attributes(:done => true)
  end
  
  def self.export(format) 
    question_identifiers = []
    all.each do |survey|
      survey.instrument.questions.each do |question|
        question_identifiers << question.question_identifier unless question_identifiers.include? question.question_identifier
        question_identifiers << question.question_identifier + '_special' unless question_identifiers.include? question.question_identifier + '_special'
        question_identifiers << question.question_identifier + '_other' unless question_identifiers.include? question.question_identifier + '_other'
      end
    end
    
    metadata_keys = []
    all.each do |survey|
      survey.metadata.keys.each do |key|
        metadata_keys << key unless metadata_keys.include? key
      end if survey.metadata
    end
    
    header = ['survey_id', 'survey_uuid', 'device_identifier', 'device_label', 'latitude', 'longitude', 'instrument_id', 'instrument_version_number', 
      'instrument_title', 'survey_start_time', 'survey_end_time', 'device_user_id', 'device_user_username'] + metadata_keys + question_identifiers 
    format << header
      
    all.each do |survey|
      row = [survey.id, survey.uuid, survey.device.identifier, survey.device.label, survey.latitude, survey.longitude, survey.instrument.id, 
        survey.instrument_version_number, survey.instrument.title, survey.responses.order('time_started').try(:first).try(:time_started), 
        survey.responses.order('time_ended').try(:last).try(:time_ended)]     
      
      survey.metadata.each do |k, v|
        key_index = header.index {|h| h == k}
        row[key_index] = v
      end if survey.metadata
      
      survey.responses.each do |response|
        index_of_identifier = header.index(response.question_identifier)
        row[index_of_identifier] = response.text if index_of_identifier
        index_of_special_identifier = header.index(response.question_identifier + '_special')
        row[index_of_special_identifier] = response.special_response if index_of_special_identifier
        index_of_other_identifier = header.index(response.question_identifier + '_other')
        row[index_of_other_identifier] = response.other_response if index_of_other_identifier
      end
      device_user_id_index = header.index('device_user_id')
      device_user_username_index = header.index('device_user_username')
      device_user_ids = survey.responses.pluck(:device_user_id).uniq.compact
      unless device_user_ids.empty?
        row[device_user_id_index] = device_user_ids.join(",")
        row[device_user_username_index] = DeviceUser.find(device_user_ids).map(&:username).uniq.join(",")   
      end
      format << row
    end
  end

end

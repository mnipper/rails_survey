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
#  completion_rate           :decimal(3, 2)
#

class Survey < ActiveRecord::Base
  attr_accessible :instrument_id, :instrument_version_number, :uuid, :device_id, :instrument_title,
    :device_uuid, :latitude, :longitude, :metadata, :completion_rate
  belongs_to :instrument
  belongs_to :device
  has_many :responses, foreign_key: :survey_uuid, primary_key: :uuid, dependent: :destroy
  delegate :project, to: :instrument
  validates :device_id, presence: true, allow_blank: false
  validates :uuid, presence: true, allow_blank: false
  validates :instrument_id, presence: true, allow_blank: false
  validates :instrument_version_number, presence: true, allow_blank: false
  paginates_per 20
  
  def percent_complete
    completion_rate || calculate_completion_rate
  end
  
  def calculate_completion_rate
    self.update(completion_rate: (responses.where.not('text = ? AND other_response = ? AND special_response = ?', nil || "", nil || "", nil || "")
    .pluck(:question_id).uniq.count.to_f / instrument.version_by_version_number(instrument_version_number)
    .questions.select{|question| question.question_type != 'INSTRUCTIONS'}.count).round(2))
    completion_rate 
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
    variable_identifiers = []
    all.each do |survey|
      survey.instrument.questions.each do |question|
        variable_identifiers << question.question_identifier unless variable_identifiers.include? question.question_identifier
        variable_identifiers << question.question_identifier + '_label' unless variable_identifiers.include? question.question_identifier + '_label'
        variable_identifiers << question.question_identifier + '_special' unless variable_identifiers.include? question.question_identifier + '_special'
        variable_identifiers << question.question_identifier + '_other' unless variable_identifiers.include? question.question_identifier + '_other'
        variable_identifiers << question.question_identifier + '_version' unless variable_identifiers.include? question.question_identifier + '_version'
        variable_identifiers << question.question_identifier + '_text' unless variable_identifiers.include? question.question_identifier + '_text' 
        variable_identifiers << question.question_identifier + '_start_time' unless variable_identifiers.include? question.question_identifier + '_start_time'
        variable_identifiers << question.question_identifier + '_end_time' unless variable_identifiers.include? question.question_identifier + '_end_time'
      end
    end
    
    metadata_keys = []
    all.each do |survey|
      survey.metadata.keys.each do |key|
        metadata_keys << key unless metadata_keys.include? key
      end if survey.metadata
    end
    
    header = ['survey_id', 'survey_uuid', 'device_identifier', 'device_label', 'latitude', 'longitude', 'instrument_id', 'instrument_version_number', 
      'instrument_title', 'survey_start_time', 'survey_end_time', 'device_user_id', 'device_user_username'] + metadata_keys + variable_identifiers
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
        identifier_index = header.index(response.question_identifier)
        row[identifier_index] = response.text if identifier_index
        special_identifier_index = header.index(response.question_identifier + '_special')
        row[special_identifier_index] = response.special_response if special_identifier_index
        other_identifier_index = header.index(response.question_identifier + '_other')
        row[other_identifier_index] = response.other_response if other_identifier_index
        label_index = header.index(response.question_identifier + '_label')
        row[label_index] = survey.option_labels(response) if label_index
        question_version_index = header.index(response.question_identifier + '_version')
        row[question_version_index] = response.question_version if question_version_index
        question_text_index = header.index(response.question_identifier + '_text')
        row[question_text_index] = Sanitize.fragment(survey.chronicled_question(response.question_identifier).try(:text)) if question_text_index
        start_time_index = header.index(response.question_identifier + '_start_time')
        row[start_time_index] = response.time_started if start_time_index
        end_time_index = header.index(response.question_identifier + '_end_time')
        row[end_time_index] = response.time_ended if end_time_index
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
  
  def chronicled_question(question_identifier)
    instrument_version.find_question_by(question_identifier: question_identifier)
  end
  
  def option_labels(response)
    labels = [] 
    versioned_question = chronicled_question(response.question_identifier)
    if response.question and versioned_question and versioned_question.has_options? 
      response.text.split(Settings.list_delimiter).each do |option_index|
        (versioned_question.has_other? and option_index.to_i == versioned_question.other_index) ? labels << "Other" : labels << versioned_question.options[option_index.to_i].to_s
      end
    end
    labels.join(Settings.list_delimiter)
  end

end

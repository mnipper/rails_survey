# == Schema Information
#
# Table name: responses
#
#  id                  :integer          not null, primary key
#  question_id         :integer
#  text                :text
#  other_response      :text
#  created_at          :datetime
#  updated_at          :datetime
#  survey_uuid         :string(255)
#  special_response    :string(255)
#  time_started        :datetime
#  time_ended          :datetime
#  question_identifier :string(255)
#  uuid                :string(255)
#  device_user_id      :integer
#  question_version    :integer          default(-1)
#

class Response < ActiveRecord::Base
  attr_accessible :question_id, :text, :other_response, :special_response, :survey_uuid,
    :time_started, :time_ended, :question_identifier, :uuid, :device_user_id,
    :question_version
  belongs_to :question
  belongs_to :survey, foreign_key: :survey_uuid, primary_key: :uuid
  delegate :device, to: :survey 
  delegate :instrument, to: :survey
  delegate :project, to: :survey
  delegate :instrument_version_number, to: :survey
  delegate :instrument_version, to: :survey
  has_one :response_image, foreign_key: :response_uuid, primary_key: :uuid
  belongs_to :device_user

  validates :question, presence: true
  validates :survey, presence: true

  after_create {|response| response.message }

  def to_s
    if question.nil? or question.options.empty?
      text
    else
      question.options[text.to_i].to_s
    end
  end

  def self.to_csv(csv_file, export_id)
    CSV.open(csv_file, "wb") do |csv|
      export(csv)
    end
    export = ResponseExport.find(export_id)
    export.update(:done => true)
  end

  def self.export(format)
    metadata_keys = []
    all.each do |response|
      response.survey.metadata.keys.each do |key|
        metadata_keys << key unless metadata_keys.include? key
      end if response.survey.metadata
    end

    header = ['qid', 'short_qid', 'instrument_id', 'instrument_version_number', 'question_version_number',
      'instrument_title', 'survey_id', 'survey_uuid', 'device_id', 'device_uuid', 'question_type', 'question_text', 'response',
      'response_labels', 'special_response', 'other_response', 'response_time_started', 'response_time_ended',
      'device_user_id', 'device_user_username'] + metadata_keys
    format << header

    all.each do |response|
      row = [response.question_identifier, "q_#{response.question_id}", response.survey.instrument_id,
        response.instrument_version_number, response.question_version, response.survey.instrument_title,
        response.survey.id, response.survey_uuid, response.survey.device.id, response.survey.device_uuid,
        response.versioned_question.try(:question_type), Sanitize.fragment(response.versioned_question.try(:text)),
        response.text, response.option_labels, response.special_response, response.other_response, response.time_started,
        response.time_ended, response.device_user.try(:id), response.device_user.try(:username)]

      if response.survey.metadata
        response.survey.metadata.each do |k, v|
          key_index = header.index {|h| h == k}
          row[key_index] = v
        end
      end

      format << row
    end
  end
  
  def self.to_spss_friendly_csv
    root = Rails.root.join('files', 'exports').to_s
    csv_file = File.new(root + "/spss#{Time.now.to_i}.csv", "a+")
    CSV.open(csv_file, "wb") do |csv|
      spss_export(csv)
    end
    csv_file
  end
  
  def self.spss_export(format)
    qids = []
    surveys = []
    all.each do |response|
      unless qids.include? response.question_identifier
        qids << response.question_identifier
      end
      unless surveys.include? response.survey
        surveys << response.survey
      end
    end
    format << qids 
    surveys.each do |survey|
      responses = []
      survey.responses.each do |response|
        responses << response.text.gsub(/,/, ';')
      end
      format << responses 
    end
  end
  
  def self.spss_label_values
    root = Rails.root.join('files', 'exports').to_s
    spss_file = File.new(root + "/#{Time.now.to_i}.sps", "a+")
    File.open(spss_file, "a+") do |file|
      write_variable_labels(file)
      write_value_labels(file)
    end
    spss_file 
  end
  
  def self.write_variable_labels(file)
    file.puts "VARIABLE LABELS"  
    qids = []
    all.each do |response|
      unless qids.include? response.question_identifier
        response_text = response.versioned_question.text.gsub(/'/, '"')
        if response.question.id == response.instrument.questions.last.id
          file.puts "#{response.question_identifier} '#{response_text}'."
        else
          file.puts "#{response.question_identifier} '#{response_text}'"
        end 
        qids << response.question_identifier 
      end 
    end
  end
  
  def self.write_value_labels(file)
    qids = []
    all.each do |response|
      if Settings.question_with_options.include? response.versioned_question.try(:question_type) 
        unless qids.include? response.question_identifier
          file.puts "VALUE LABELS" 
          file.puts response.question_identifier 
          qids << response.question_identifier 
          options = response.versioned_question.options
          options.each do |option_index|
            option_text = (response.versioned_question.options[options.index(option_index)].to_s).gsub(/'/, '"')
            if option_index == options.last
              file.puts "#{options.index(option_index)} '#{option_text}'."
            else
              file.puts "#{options.index(option_index)} '#{option_text}'" 
            end 
          end 
        end 
      end
    end
    file.puts "EXECUTE." 
  end
  
  def self.value_labels_csv
    root = Rails.root.join('files', 'exports').to_s
    csv_file = File.new(root + "/#{Time.now.to_i}value_labels.csv", "a+")
    CSV.open(csv_file, "wb") do |csv|
      export_value_labels(csv)
    end
    csv_file
  end
  
  def self.export_value_labels(format)
    format << ['variable_identifier', 'variable_type', 'variable_label', 'value_label', 'label_type']
    questions = all.first.instrument.questions 
    questions.each do |question|
      if question.has_options?
        question.options.each do |option|
          format << [question.question_identifier, question.question_type, option.text, question.options.index(option), 'value label']
        end 
      else
        format << [question.question_identifier, question.question_type, question.text, '', 'question label']
      end 
    end
  end

  def grouped_responses
    self.group(:created_at)
  end

  def time_taken_in_seconds
    if time_ended && time_started
      time_ended - time_started
    end
  end

  def option_labels
    labels = [] 
    if question and versioned_question and versioned_question.has_options? 
      text.split(Settings.list_delimiter).each do |option_index|
        if versioned_question.has_other? and option_index.to_i == versioned_question.other_index
          labels << "Other"
        else
          labels << versioned_question.options[option_index.to_i].to_s
        end
      end
    end
    labels.join(Settings.list_delimiter)
  end

  def dictionary
    labels = [] 
    if question and question.has_options?
      question.options.with_deleted.each_with_index do |option, index|
        labels << "#{index}=\"#{option}\""
      end
      labels << "#{question.other_index}=\"Other\"" if question.has_other?
    end
    labels.join(Settings.dictionary_delimiter)
  end

  def versioned_question
    @versioned_question ||= instrument_version.find_question_by(question_identifier: question_identifier)
  end
  
  def message
    msg =  { count: Response.count }
    begin
      $redis.publish 'responses-create', msg.to_json
    rescue Errno::ECONNREFUSED
      logger.debug 'Redis is not running'
    end
  end
end

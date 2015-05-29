# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Project < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :instruments, dependent: :destroy
  has_many :surveys, through: :instruments
  has_many :project_devices, dependent: :destroy
  has_many :devices, through: :project_devices
  has_many :responses, through: :surveys
  has_many :response_images, through: :responses
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :response_exports 
  has_many :response_images_exports, through: :response_exports
  has_many :questions, through: :instruments
  has_many :images, through: :questions
  has_many :options, through: :questions
  has_many :sections, through: :instruments 
  has_many :device_users
  has_many :skips, through: :options 
  has_many :rules, through: :instruments
  has_many :grids, through: :instruments
  has_many :grid_labels, through: :grids
  
  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: true
  
  def instruments_to_sync(instrument_ids_and_versions, deleted_instruments_ids)
    return instruments.with_deleted if instrument_ids_and_versions.blank?
    synced_instruments = instruments.where(id: instrument_ids_and_versions.keys.map(&:to_i))
    unsynced_instruments = instruments.with_deleted - synced_instruments 
    unless deleted_instruments_ids.blank?
      synced_deleted_instruments = instruments.with_deleted.where(id: deleted_instruments_ids.split(",").map(&:to_i))
      unsynced_instruments -= synced_deleted_instruments if synced_deleted_instruments
    end
    instrument_ids_and_versions.each do |instrument_id, instrument_version|
      instrument = instruments.where(id: instrument_id.to_i).try(:first)
      unsynced_instruments << instrument if !instrument.blank? && instrument.current_version_number > instrument_version
    end
    unsynced_instruments
  end
  
  def questions_to_sync(instrument_ids_and_versions, deleted_questions_ids) 
    return questions.with_deleted if instrument_ids_and_versions.blank?
    synced_instruments = instruments.where(id: instrument_ids_and_versions.keys.map(&:to_i))
    synced_questions = synced_instruments.map {|inst| inst.questions}.flatten
    unsynced_questions = questions.with_deleted - synced_questions
    unless deleted_questions_ids.blank?
      synced_deleted_questions = questions.with_deleted.where(id: deleted_questions_ids.split(",").map(&:to_i))
      unsynced_questions -= synced_deleted_questions if synced_deleted_questions
    end
    instrument_ids_and_versions.each do |instrument_id, instrument_version|
      instrument = instruments.where(id: instrument_id.to_i).try(:first)
      unsynced_questions << instrument.questions.select{|question| question.instrument_version_number > instrument_version} unless instrument.blank?
    end
    unsynced_questions.flatten
  end
  
  def options_to_sync(instrument_ids_and_versions, deleted_options_ids)
    return options.with_deleted if instrument_ids_and_versions.blank?
    synced_instruments = instruments.where(id: instrument_ids_and_versions.keys.map(&:to_i))
    synced_options = synced_instruments.map {|inst| inst.options}.flatten
    unsynced_options = options.with_deleted - synced_options
    unless deleted_options_ids.blank?
      synced_deleted_options = options.with_deleted.where(id: deleted_options_ids.split(",").map(&:to_i))
      unsynced_options -= synced_deleted_options if synced_deleted_options
    end
    instrument_ids_and_versions.each do |instrument_id, instrument_version|
      instrument = instruments.where(id: instrument_id.to_i).try(:first)
      unsynced_options << instrument.options.select {|option| option.instrument_version_number > instrument_version} unless instrument.blank?
    end
    unsynced_options.flatten
  end
  
  def non_responsive_devices
    devices.includes(:surveys).where('surveys.updated_at < ?', Settings.danger_zone_days.days.ago).order('surveys.updated_at ASC')
  end

  def instrument_response_exports
    ResponseExport.find_all_by_instrument_id(instrument_ids).sort { |x,y| y.created_at <=> x.created_at }
  end

  def daily_response_count 
    count_per_day = {}
    array = []
    response_count_per_period(:group_responses_by_day).each do |day, count|
      count_per_day[day.to_s[5..9]] = count.inject{|sum,x| sum + x}
    end
    array << count_per_day
  end
  
  def hourly_response_count
    count_per_hour = {}
    array = []
    response_count_per_period(:group_responses_by_hour).each do |hour, count|
      count_per_hour[hour.to_s] = count.inject{|sum,x| sum + x}
    end
    puts sanitize(count_per_hour)
    array << sanitize(count_per_hour)
  end

  private
  def sanitize(hash)
    (0..23).each do |h|
      hour = sprintf '%02d', h
      hash[hour] = 0 unless hash.has_key?(hour)
    end
    hash
  end
  
  def response_count_per_period(method)
    grouped_responses = []
    self.instruments.each do |instrument|
      instrument.surveys.each do |survey|
        grouped_responses << survey.send(method)
      end
    end
    merge_period_counts(grouped_responses)
  end
  
  def merge_period_counts(grouped_responses)
    grouped_responses.map(&:to_a).flatten(1).reduce({}) {|h,(k,v)| (h[k] ||= []) << v; h}
  end
  
end

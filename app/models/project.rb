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
  #To enable synchronization to devices of only questions/options/images that belong to a project
  has_many :questions, through: :instruments
  has_many :images, through: :questions
  has_many :options, through: :questions
  has_many :sections, through: :instruments 
  has_many :device_users
  
  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: true
  
  def non_responsive_devices
    devices.includes(:surveys).where('surveys.updated_at < ?', 1.day.ago).order('surveys.updated_at ASC')
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

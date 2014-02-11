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
  has_many :user_projects
  has_many :users, through: :user_projects

  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: true

  def daily_response_count 
    grouped_responses = []
    self.instruments.each do |instrument|
      instrument.surveys.each do |survey|
        grouped_responses << survey.group_responses_by_day
      end
    end
    grouped_responses = grouped_responses.map(&:to_a).flatten(1).reduce({}) {|h,(k,v)| (h[k] ||= []) << v; h}
    hash = {}
    array = []
    grouped_responses.each do |key, value|
      hash[key[0..9]] = value.inject{|sum,x| sum + x}
    end
    array << hash
    puts array
    array
  end
  
  def hourly_response_count
    responses = []
    self.instruments.each do |instrument|
      instrument.surveys.each do |survey|
        responses << survey.group_responses_by_hour
      end
    end
    responses = responses.map(&:to_a).flatten(1).reduce({}) {|h,(k,v)| (h[k] ||= []) << v; h}
    hash = {}
    sorted_array = []
    responses.each do |key, value|
      hash[key] = value.inject{|sum,x| sum + x}
    end
    array = sanitize(hash)
    sorted_array << array
    puts sorted_array
    sorted_array 
  end
  
  private
  def sanitize(hash)
    (0..23).each do |h|
      hour = ''
      if h < 10
        hour = '0'+h.to_s 
      else
        hour = h.to_s
      end
      unless hash.has_key?(hour) 
        hash[hour] = 0
      end
    end
    array = hash.sort_by {|k, v| k}
    new_hash = Hash.new{ |h,k| h[k]=[] }
    array.each{ |k,v| new_hash[k] = v }
    new_hash
  end
  
end

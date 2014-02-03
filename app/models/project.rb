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
    grouped_responses.each do |key, value|
      hash[key] = value.inject{|sum,x| sum + x}
    end
    hash
  end
  
end

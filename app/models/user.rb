# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  roles_mask             :integer
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#

class User < ActiveRecord::Base
  include RoleModel
  include ComplexPassword
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable,
         :lockable
  attr_accessible :email, :password, :password_confirmation, :project_ids, :roles_mask, :roles 
  before_save :ensure_authentication_token
  has_many :user_projects 
  has_many :projects, through: :user_projects
  roles :admin, :manager, :translator, :analyst, :user 
  after_create :set_default_role

  def set_default_role
    self.roles = [:user]  #TODO FIX - users not assigned any role upon creation
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end

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
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  last_active_at         :datetime
#  gauth_secret           :string(255)
#  gauth_enabled          :string(255)      default("f")
#  gauth_tmp              :string(255)
#  gauth_tmp_datetime     :datetime
#

class User < ActiveRecord::Base
	attr_accessor :gauth_token
  include ComplexPassword
  devise :google_authenticatable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :lockable
  attr_accessible :email, :password, :password_confirmation, :project_ids, :role_ids, :gauth_enabled, :gauth_tmp, :gauth_tmp_datetime
  before_save :ensure_authentication_token
  after_create :set_default_role 
  has_many :user_projects 
  has_many :projects, through: :user_projects
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  def set_default_role
    role = Role.find_by_name("user")
    return unless role
    UserRole.create(:user_id => self.id, :role_id => role.id)  
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end
  
  def user?
    roles.find_by_name("user")
  end
  
  def admin?
    roles.find_by_name("admin")
  end
  
  def manager?
    roles.find_by_name("manager")
  end
  
  def analyst?
    roles.find_by_name("analyst")
  end
  
  def translator?
    roles.find_by_name("translator")
  end

  private
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end

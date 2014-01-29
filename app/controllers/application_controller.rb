class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Devise authentication
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  include ApplicationHelper
  include ProjectsHelper

  #Pundit authorization & verification
  include Pundit
  after_filter :verify_authorized,  except: :index
  after_filter :verify_policy_scoped, only: :index
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource_or_scope)
    root_path
  end

  def respond_to_ajax
    if request.xhr?
      respond_to do |format|
        format.js
      end
    end
  end

  private
  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      sign_in user, store: false
    end
  end

  def user_not_authorized
    flash[:error] = 'You are not authorized to perform this action.'
    #redirect_to request.referer || root_path
  end

end

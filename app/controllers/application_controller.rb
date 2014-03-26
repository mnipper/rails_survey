class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include ProjectsHelper
  before_filter :authenticate_user_from_token!
  before_filter :store_location
  before_filter :authenticate_user!

  def after_sign_in_path_for(resource_or_scope)
    set_current_project_id(session[:previous_url])
    session[:previous_url] || root_path
  end
  
  def after_update_path_for(resource)
    session[:previous_url] || root_path
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

end

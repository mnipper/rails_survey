class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
    instruments_path
  end

  def respond_to_ajax
    if request.xhr?
      respond_to do |format|
        format.js
      end
    end
  end


end

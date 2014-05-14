module SessionsHelper
  def store_location
    if (request.fullpath != "/users/sign_in" && request.fullpath != "/users/sign_up" &&
      request.fullpath != "/users/password" && request.fullpath != "/users/sign_out" && 
      request.fullpath != "/admin/login" && !request.xhr?) 
      session[:previous_url] = request.fullpath 
    end
  end
end
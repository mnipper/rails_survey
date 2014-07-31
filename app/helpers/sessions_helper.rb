module SessionsHelper
  def store_location
    if (request.fullpath != "/users/sign_in" && request.fullpath != "/users/sign_up" &&
      request.fullpath != "/users/password" && request.fullpath != "/users/password/new"  && 
      request.fullpath != "/users/password/edit" && request.fullpath != "/users/sign_out" && 
      request.fullpath != "/admin/login"  && request.fullpath != "/users/checkga" &&
      request.fullpath != "/admin/checkga" && !request.xhr?) 
      session[:previous_url] = request.fullpath 
    else
      session[:previous_url] = "/"
    end
  end
end

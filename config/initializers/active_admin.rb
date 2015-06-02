ActiveAdmin.setup do |config|
  config.site_title = "iSEE Admin"
  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path
  config.batch_actions = true
  config.filters = false
  config.skip_before_filter :authenticate_user_from_token!
  config.skip_before_filter :authenticate_user!
end
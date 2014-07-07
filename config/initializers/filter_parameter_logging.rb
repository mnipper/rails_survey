# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
if Rails.env.production?
  Rails.application.config.filter_parameters += [:password, :text, :access_token]
end

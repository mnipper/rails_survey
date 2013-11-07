Capybara.register_driver :selenium do |app|
  http_client = Selenium::WebDriver::Remote::Http::Default.new
  http_client.timeout = 300
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => http_client)
end

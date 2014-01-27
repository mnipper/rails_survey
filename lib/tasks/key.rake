namespace :key do
  desc "Generate keys"
  task apikey: :environment do
    key = ApiKey.create!
    puts "Generated api access token: #{key.access_token}"
  end
end

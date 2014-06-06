
set :stage, :production
set :branch, 'master'
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
#server 'chpir-survey-01.oit.duke.edu', user: 'dmtg', roles: %w{db}, primary: true 
server 'wci-chpir.duke.edu', user: 'dmtg', roles: %w{web app db}, primary: true 
server 'adaptlab.vm.duke.edu', user: 'rover', roles: %w{web app db}, primary: true 
set :deploy_to, '/var/www/rails_survey'
set :rails_env, :production

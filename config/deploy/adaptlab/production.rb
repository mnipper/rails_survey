set :branch, 'master'
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
server 'adaptlab.vm.duke.edu', user: 'dmtg', roles: %w{web app db}, primary: true  
set :deploy_to, '/var/www/rails_survey'
set :rails_env, :production

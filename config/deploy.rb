# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'rails_survey' 
set :deploy_user, 'dmtg'
set :scm, :git 
set :repo_url, 'git@github.com:mnipper/rails_survey.git'
set :use_sudo, false
set :rails_env, 'production'
set :deploy_via, :copy
set :ssh_options, { :forward_agent => true, :port => 2222 }
set :pty, false
set :format, :pretty
set :keep_releases, 5
set :linked_files, %w{config/database.yml config/secret_token.txt config/local_env.yml}
set :linked_dirs, fetch(:linked_dirs).push("bin" "log" "tmp/pids" "tmp/cache" "tmp/sockets" "vendor/bundle" "public/system")
set :branch, 'master'

namespace :deploy do
 
  task :load_schema do
    execute "cd #{current_path}; rake db:schema:load RAILS_ENV=#{rails_env}"
  end
 
  task :cold do 
    update
    load_schema
    start
  end

  desc 'Restart Application'
  task :restart do
    desc "restart redis"
    on roles(:app) do
      execute "sudo /etc/init.d/redis-server restart"
    end
    desc "restart node"
    on roles(:app), in: :sequence, wait: 5 do
      execute "sudo ln -s /etc/httpd/conf/ssl.crt/wci-chpir_duke_edu.cer #{release_path}/node && sudo ln -s /etc/httpd/conf/ssl.key/wci-chpir_duke_edu-private.key #{release_path}/node"
      execute "sudo restart realtime-app || sudo start realtime-app"
    end
    desc "restart phusion passenger"
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, current_path.join('tmp/restart.txt')
    end  
  end

  task :npm_install do
    on roles(:app) do
      execute "cd #{release_path}/node && sudo rm -rf node_modules && npm install"
    end 
  end
    
  after :finishing, 'deploy:cleanup'
  after 'deploy:publishing', 'deploy:restart'
  after "deploy:updated", "deploy:npm_install"
  
end

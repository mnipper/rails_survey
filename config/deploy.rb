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
set :keep_releases, 5
set :linked_files, %w{config/database.yml config/secret_token.txt}
set :linked_dirs, fetch(:linked_dirs).push("bin" "log" "tmp/pids" "tmp/cache" "tmp/sockets" "vendor/bundle" "public/system")
set :branch, 'master'


namespace :deploy do
 
  task :load_schema do
    run "cd #{current_path}; rake db:schema:load RAILS_ENV=#{rails_env}"
  end
 
  task :cold do 
    update
    load_schema
    start
  end

  desc 'Start Forever'
  task :stop_node do
    run "/usr/local/bin/forever stopall; true"
  end

  desc 'Stop Forever'
  task :start_node do 
    run "cd #{current_path}/node && /usr/local/bin/forever start server.js"
  end 
  
  desc 'Restart Forever'
  task :restart_node do
    stop_node
    sleep 5
    start_node
  end
  
  desc 'Restart passenger & apache'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, current_path.join('tmp/restart.txt')
      run "sudo service apache2 restart"
    end
  end

  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  after :publishing, :restart
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end

end

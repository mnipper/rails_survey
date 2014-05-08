# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

set :stage, :production
set :branch, 'master'
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :server_name, 'wci-chpir.duke.edu'
server 'wci-chpir.duke.edu', user: 'dmtg', roles: %w{web app db}, primary: true 
set :deploy_to, '/var/www/rails_survey'
set :rails_env, :production
#role :app, %w{deploy@wci-chpir.duke.edu}
#role :web, %w{deploy@wci-chpir.duke.edu}
#role :db,  %w{deploy@wci-chpir.duke.edu}


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
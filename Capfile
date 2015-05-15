require 'capistrano/setup'
require 'capistrano/deploy'
require 'sshkit/dsl'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/sidekiq'
require 'capistrano/sidekiq/monit'
require 'capistrano/rails/migrations'

Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }

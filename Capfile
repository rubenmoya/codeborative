
require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rbenv'

set :rbenv_type, :user
set :rbenv_ruby, '2.2.2'

Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }


require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rbenv'

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.2.0'

Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }

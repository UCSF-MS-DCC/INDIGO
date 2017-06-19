# Load DSL and Setup Up Stages
require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/puma'
install_plugin Capistrano::Puma
require 'capistrano/rails/console'
require 'capistrano/figaro_yml'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

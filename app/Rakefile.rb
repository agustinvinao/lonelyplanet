require File.expand_path("../config/application.rb", __FILE__)
require 'bundler/setup'
require 'rake/testtask'
include ActiveRecord::Tasks

db_dir                                = File.expand_path('../db', __FILE__)
config_dir                            = File.expand_path('../config', __FILE__)
DatabaseTasks.env                     = ENV['ENV'] || 'development'
DatabaseTasks.db_dir                  = db_dir
DatabaseTasks.database_configuration  = YAML.load(File.read(File.join(config_dir, 'database.yml')))
DatabaseTasks.migrations_paths        = File.join(db_dir, 'migrate')
DatabaseTasks.root                    = File.dirname(__FILE__)

task :environment do
  ActiveRecord::Base.configurations   = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection DatabaseTasks.env
end

load 'active_record/railties/databases.rake'

Dir.glob('lib/tasks/*.rake').each { |r| load r}


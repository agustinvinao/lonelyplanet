require 'nokogiri'
require 'active_record'

Dir[
  File.join(".", "**/*.rb")
  ].each do |item|
  require item unless item =~ /db|Rakefile|test|application/
end

module App
  def self.root
    File.expand_path('../../', __FILE__)
  end
end

# fix to for uninitialized constant ActiveRecord::Tasks::SQLiteDatabaseTasks::Rails
module Rails
  def self.root
    File.dirname(__FILE__)
  end
  def self.env
    ENV['ENV']
  end
  def self.application
    Paths.new
  end
end

class Paths
  def paths
    { "db/migrate" => [File.expand_path("../db/migrate", __FILE__)] }
  end

  def load_seed
    load File.expand_path("../db/seeds.rb", __FILE__)
  end
end

logger        = Logger.new(STDOUT)
logger.level  = Logger::ERROR

begin
  ArgsChecker.has_database_config?
rescue NoDatabaseConfigException => e
  logger.error e.message
end
ActiveRecord::Base.logger = Logger.new(STDERR)

config_dir     = File.expand_path('../', __FILE__)
env            = ENV['ENV'] || 'development'
configuration  = YAML.load(File.read(File.join(config_dir, 'database.yml')))
ActiveRecord::Base.establish_connection(configuration[env])
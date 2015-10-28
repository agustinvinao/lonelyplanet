require 'nokogiri'
require 'database_cleaner'
namespace :importer do

  task :truncate do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  desc "Import destinations.xml (XML_DESTINATIONS=path_to_file)"
  task destinations: [:truncate] do

    logger = Logger.new(STDOUT)
    begin
      ArgsChecker.is_environment_variable?('XML_DESTINATIONS')
      ArgsChecker.is_file?('XML_DESTINATIONS')
    rescue NoEnvironmentVariableException => e
      logger.error e.message
      exit
    rescue IsNotFileException => e
      logger.error e.message
      exit
    end

    destinations = ENV['XML_DESTINATIONS']

    NodeParser.destination_each_node(File.open(destinations)) do |attributes, xml|
      destination = Destination.find_or_initialize_by(atlas_id: attributes['atlas_id'])
      destination.update(attributes)

      NodeParser.topic_each_node(xml) do |topic_name, entries|
        topic = Topic.find_or_create_by(title: topic_name, destination_id: destination.id)
        entries.each{|entry| entry.topic_id = topic.id}
        entries.map(&:save)
      end

    end
  end

  desc "Import taxonomy.xml (XML_TAXONOMY=path_to_file)"
  task :taxonomy do
    logger = Logger.new(STDOUT)
    begin
      ArgsChecker.is_environment_variable?('XML_TAXONOMY')
      ArgsChecker.is_file?('XML_TAXONOMY')
    rescue NoEnvironmentVariableException => e
      logger.error e.message
      exit
    rescue IsNotFileException => e
      logger.error e.message
      exit
    end

    taxonomy  = ENV['XML_TAXONOMY']
    doc       = Nokogiri::XML(File.open(taxonomy))
    node      = doc.xpath('//taxonomies/taxonomy/node')
    parent_children = NodeParser.taxonomy_relation node

    parent_children.each do |parent_child|
      parent = Destination.find_by_atlas_id(parent_child[:parent])
      child = Destination.find_by_atlas_id(parent_child[:child])
      child.update({parent_id: parent.id}) if parent
    end
  end

  desc "Import destination.xml and taxonomy.xml (XML_DESTINATIONS=path_to_file, XML_TAXONOMY=path_to_file)"
  task all: [:destinations, :taxonomy] do
  end
end
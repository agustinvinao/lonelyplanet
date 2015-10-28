namespace :runner do
  desc 'Run HTML generator (OVERVIEW: true/false, OUTPUT_PATH=path_to_folder)'
  task :html do
    logger = Logger.new(STDOUT)
    logger.level = Logger::ERROR
    begin
      ArgsChecker.is_environment_variable?('OVERVIEW')
    rescue NoEnvironmentVariableException => e
      logger.error e.message
      exit
    end

    begin
      ArgsChecker.is_environment_variable?('OUTPUT_PATH')
      ArgsChecker.is_folder?(ENV['OUTPUT_PATH'])
    rescue NoEnvironmentVariableException => e
      logger.error e.message
      exit
    rescue IsNotFolderException => e
      logger.error e.message
      exit
    end

    dhr = DumpHtml.new
    dhr.run({overview: ENV['OVERVIEW'], output: ENV['OUTPUT_PATH']})
  end

  desc "Import XML and create HTML files (XML_DESTINATIONS=path_to_file, XML_TAXONOMY=path_to_file, OUTPUT_PATH=path_to_folder, OVERVIEW: true/false)"
  task all: ['importer:all', :html] do
  end
end
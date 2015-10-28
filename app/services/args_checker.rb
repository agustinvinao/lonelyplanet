module ArgsChecker
  def self.file_exists?(path_to_file)
    path_to_file.present? && File.exist?(File.expand_path(File.absolute_path(path_to_file)))
  end

  def self.is_environment_variable?(name)
    return true if ENV[name].present?
    raise NoEnvironmentVariableException, "#{name} is not an environment variable or is not defined"
  end

  def self.is_file?(name)
    return true if ENV[name].present? && File.exist?(File.expand_path(File.absolute_path(ENV[name])))
    raise IsNotFileException, "#{name} is not a file"
  end

  def self.has_database_config?
    return true if File.exist?(File.join(App.root, '/config/database.yml'))
    raise NoDatabaseConfigException, "File not found #{App.root}/config/database.yml"
  end

  def self.is_folder?(folder_path)
    return true if folder_path.present? && File.directory?(File.expand_path(File.absolute_path(folder_path)))
    raise IsNotFolderException, "#{folder_path} not defiend or is not a directory"
  end
end
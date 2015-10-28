require 'test_helper'

describe ArgsChecker do
  before do
    @path_nil = nil
    @path_empty = ''
    @evar = "envvar#{"%05d" % rand(100)}"
    @path_no_file = "test#{"%05d" % rand(100)}"
  end
  describe 'file_exists' do
    it "doesn't exists as a file" do
      ArgsChecker.file_exists?(@path_nil).must_be :==, false
      ArgsChecker.file_exists?(@path_empty).must_be :==, false
      ArgsChecker.file_exists?(@path_no_file).must_be :==, false
    end

    it "exists as a file" do
      ArgsChecker.file_exists?(__FILE__).must_be :==, true
    end
  end
  describe 'is_environment_variable?' do
    it 'raise NoEnvironmentVariableException' do
      lambda { ArgsChecker.is_environment_variable?('test') }.must_raise NoEnvironmentVariableException
    end
  end
  describe 'is_file?' do
    it 'raise IsNotFileException' do
      ENV[@evar] = @path_no_file
      lambda { ArgsChecker.is_file?(@evar) }.must_raise IsNotFileException
    end
  end
end

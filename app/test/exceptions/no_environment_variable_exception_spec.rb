require 'test_helper'

describe NoEnvironmentVariableException do
  it 'raise the exception' do
    lambda { fail NoEnvironmentVariableException }.must_raise NoEnvironmentVariableException
  end
end
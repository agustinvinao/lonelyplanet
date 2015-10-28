require 'test_helper'

describe IsNotFileException do
  it 'raise the exception' do
    lambda { fail IsNotFileException }.must_raise IsNotFileException
  end
end
require 'test_helper'

describe Generator do
  before do
    @destination = create :destination
    @generator = Generator.new({destination: @destination, overview: false})
  end

  it "respond to destination" do
    @generator.must_respond_to(:destination)
    @generator.destination.must_be :==, @destination
  end

  it "respond to overview" do
    @generator.must_respond_to(:overview)
    @generator.overview.must_be :==, false
  end

  it "respond to perform" do
    @generator.must_respond_to(:perform)
  end
end
require 'test_helper'

describe Destination do
  before do
    @destination = create :destination
    @destinations = create_list(:destination, 2, parent_id: @destination.id)
  end

  describe 'relations' do
    it 'has many topics' do
      @destination.must_respond_to(:topics)
    end
    it 'it may have a parent' do
      @destination.must_respond_to(:parent)
    end
    it 'ite may have children' do
      @destination.must_respond_to(:children)
    end
  end

  it 'has a link based on atlasid' do
    @destination.link.must_be :==, "#{@destination.atlas_id}.html"
  end

  it 'should be possible to check if it has children' do
    @destination.has_children?.must_be :==, true
    @destinations.first.has_children?.must_be :==, false
  end

  it 'should be possible to check if it has a parent' do
    @destination.has_parent?.must_be :==, false
    @destinations.first.has_parent?.must_be :==, true
  end

  it 'has a parent instance of Destination' do
    @destinations.first.parent.must_be_instance_of(Destination)
  end

  it 'has each children instance of Destination' do
    @destination.children.first.must_be_instance_of(Destination)
  end

end
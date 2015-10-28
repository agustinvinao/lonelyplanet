require 'test_helper'

describe Topic do
  before do
    @topic = create :topic
    @entries = create_list(:entry, 5, topic_id: @topic.id)
  end

  describe 'relations' do
    it 'belongs_to destination' do
      @topic.must_respond_to(:destination)
    end

    it 'has many entries' do
      @topic.must_respond_to(:entries)
    end
  end

  it 'should update the entries count' do
    topic = Topic.find(@topic.id)
    topic.entries_count.must_be :==, @entries.length
  end

  it 'has capilized title to show' do
    @topic.title_capitalized.must_be :==, @topic.title.gsub(/_/, ' ').capitalize
  end
end
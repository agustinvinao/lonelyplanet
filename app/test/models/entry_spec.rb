require 'test_helper'

describe Entry do
  before do
    @topic = create :topic
    @entries = create_list(:entry, 5, topic_id: @topic.id)
    @entries << create(:entry, is_overview: true, topic_id: @topic.id)
  end

  describe 'relations' do
    it 'belongs_to topic' do
      @entries.sample.must_respond_to(:topic)
    end
  end
  describe 'overview scope' do
    it 'responds to overview' do
      Entry.must_respond_to(:overview)
    end
    it 'returns only overview entries' do
      @topic.entries.overview.length.must_be :==, 1
    end
  end
end
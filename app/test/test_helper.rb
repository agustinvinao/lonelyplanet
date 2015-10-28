ENV['ENV'] = 'test'

require File.expand_path('../../config/application', __FILE__)
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/benchmark'
require 'minitest/mock'
require 'database_cleaner'
require 'factory_girl'
require 'rake'

DatabaseCleaner.strategy = :truncation
ActiveRecord::Base.logger.level = 1

class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end
class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
  before do
    DatabaseCleaner.clean
  end
end

FactoryGirl.define do
  sequence(:title) { |n| "title_#{n}" }
  sequence(:cdata) { |n| "cdata#{n}" }
  sequence(:entry_id) { |n| n }
  sequence(:topic_id) { |n| n }
  sequence(:atlasid) { |n| "%05d" % n }

  factory :entry do
    id { generate(:entry_id) }
    cdata { generate(:cdata) }
    is_overview false
    title { generate(:title) }
    association :topic, factory: :topic
  end

  factory :topic do
    id { generate(:topic_id) }
    title { generate(:title) }
    entries_count 0
    association :destination, factory: :destination
  end

  factory :destination do
    atlas_id { generate(:atlasid) }
    asset_id ""
    title { generate(:title) }
    titleascii { "#{title.gsub(/-/,'')}" }
    parent_id 0
  end
end
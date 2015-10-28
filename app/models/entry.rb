class Entry < ActiveRecord::Base
  belongs_to :topic, counter_cache: true

  scope :overview, -> {where(is_overview: true)}
end
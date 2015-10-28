class Topic < ActiveRecord::Base
  belongs_to :destination
  has_many :entries

  def title_capitalized
    title.gsub(/_/, ' ').capitalize
  end
end
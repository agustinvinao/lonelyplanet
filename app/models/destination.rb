class Destination < ActiveRecord::Base
  belongs_to :parent, class_name: "Destination"
  has_many :children, class_name: "Destination", foreign_key: "parent_id"
  has_many :topics

  scope :wihout_parent,-> {where(parent_id: nil)}

  def has_parent?
    parent.present?
  end

  def has_children?
    children.exists?
  end

  def link
    "#{atlas_id}.html"
  end
end
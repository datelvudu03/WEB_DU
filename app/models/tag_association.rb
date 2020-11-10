class TagAssociation < ApplicationRecord

  belongs_to :tag
  belongs_to :task
  accepts_nested_attributes_for :task
end

class Tag < ApplicationRecord
  belongs_to :user
  has_many :tag_associations
  has_many :tasks, through: :tag_associations
  accepts_nested_attributes_for :tag_associations
end

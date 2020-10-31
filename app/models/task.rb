class Task < ApplicationRecord


  belongs_to :user, optional: true
  belongs_to :category, optional: true

  has_many :tag_associations
  has_many :tags, through: :tag_associations


end

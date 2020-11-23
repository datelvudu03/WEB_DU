  class Task < ApplicationRecord


    belongs_to :user, optional: true
    belongs_to :category, optional: true

    has_many :tag_associations, dependent: :destroy
    has_many :tags, through: :tag_associations

    self.per_page = 30

    scope :task_with_cat, ->(category_id) { where('category_id = ?', category_id) }
    scope :zero_task, -> { where(category_id: 2_984_372_348_947) }


  end

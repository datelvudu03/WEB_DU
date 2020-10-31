class TagAssociation < ApplicationRecord
  belongs_to :tag
  belongs_to :task

end

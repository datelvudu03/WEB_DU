class CreateTagAssociations < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_associations do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :task, index: true
      t.timestamps
    end
  end
end

class CreateGroupTags < ActiveRecord::Migration[7.0]
  def change
    create_table :group_tags do |t|
      t.references :question, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.integer :author_id, index: true, null: true
      t.integer :user_id, index: true, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end

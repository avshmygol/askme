class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.integer :author_id, index: true, null: false
      t.integer :user_id, index: true, null: false
      t.text :body

      t.timestamps
    end
  end
end

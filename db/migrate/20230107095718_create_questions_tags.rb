class CreateQuestionsTags < ActiveRecord::Migration[7.0]
  def change
    create_table :questions_tags, :id => false do |t|
      t.references :question, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end

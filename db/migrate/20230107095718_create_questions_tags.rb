class CreateQuestionsTags < ActiveRecord::Migration[7.0]
  def change
    create_table :questions_tags do |t|
      t.references :question, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps

      t.index %i[question_id tag_id], unique: true, name: 'unique_question_tag'
    end
  end
end

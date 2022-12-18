class AddHiddenToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :hidden, :boolean
  end
end

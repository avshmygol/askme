class QuestionsTag < ApplicationRecord
  # Модель связи вопросов и тэгов
  belongs_to :question
  belongs_to :tag
end

# Модель связи вопросов и тэгов
class QuestionsTag < ApplicationRecord
  belongs_to :question
  belongs_to :tag
end

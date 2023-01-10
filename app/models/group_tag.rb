class GroupTag < ActiveRecord::Base
  # Модель связи вопросов и тэгов
  belongs_to :question
  belongs_to :tag
end

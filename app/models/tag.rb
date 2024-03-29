class Tag < ApplicationRecord
  # Тэг может быть упомянут во многих вопросах (запрос через таблицу связей)
  has_many :questions_tags, dependent: :destroy
  has_many :questions, through: :questions_tags

  REGEXP = /#[[:word:]-]+/

  validates :name, presence: true, length: { maximum: 255 }
end

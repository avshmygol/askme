class Tag < ApplicationRecord
  # Тэг может быть упомянут во многих вопросах (запрос через таблицу связей)
  has_many :group_tags
  has_many :questions, :through => :group_tags

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end

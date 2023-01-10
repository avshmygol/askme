class Question < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  belongs_to :user

  # Вопрос может иметь много тэгов (запрос через таблицу связей)
  has_many :group_tags
  has_many :tags, :through => :group_tags

  after_create :update_question_tags
  after_update :update_question_tags

  validates :body, presence: true, length: { maximum: 280 }

  # private

  def update_question_tags
    self.tags.clear
    hashtags = ("#{self.body} #{self.answer.to_s}").downcase.scan(/#[[:word:]-]+/)
    hashtags.uniq.map do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.delete("#"))
      self.tags << tag
    end
  end
end

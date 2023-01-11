class Question < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  belongs_to :user

  # Вопрос может иметь много тэгов (запрос через таблицу связей)
  has_many :questions_tags, dependent: :destroy
  has_many :tags, through: :questions_tags

  after_create :update_question_tags
  after_update :update_question_tags

  private

  validates :body, presence: true, length: { maximum: 280 }

  def update_question_tags
    tags.clear
    hashtags = ("#{body} #{answer.to_s}").downcase.scan(/#[[:word:]-]+/)
    hashtags.uniq.map do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.delete("#"))
      tags << tag
    end
  end
end

class Question < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  belongs_to :user

  # Вопрос может иметь много тэгов (запрос через таблицу связей)
  has_many :questions_tags, dependent: :destroy
  has_many :tags, through: :questions_tags

  after_commit :update_question_tags

  validates :body, presence: true, length: { maximum: 280 }

  private

  def update_question_tags
    tags.clear
    hashtags = "#{body.to_s} #{answer.to_s}".downcase.scan(Tag::REGEXP)
    tags <<
      hashtags.uniq.map do |hashtag|
        Tag.create_or_find_by(name: hashtag.delete("#"))
      end
  end
end

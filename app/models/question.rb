class Question < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  belongs_to :user
  has_and_belongs_to_many :tags

  after_create :update_question_tags
  after_update :update_question_tags

  private

  validates :body, presence: true, length: { maximum: 280 }

  def update_question_tags
    self.tags.clear
    hashtags = (self.body + self.answer).downcase.scan(/#[[:word:]-]+/)
    hashtags.uniq.map do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.delete("#"))
      self.tags << tag
    end
  end
end

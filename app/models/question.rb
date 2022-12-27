class Question < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :user

  private

  validates :body, presence: true, length: { maximum: 280 }
end

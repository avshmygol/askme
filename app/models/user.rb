class User < ApplicationRecord
  has_many :questions, dependent: :delete_all

  has_secure_password

  before_save :downcase_nickname

  def to_param
    nickname
  end

  private

  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 }, format: { with: /\A[0-9a-z_]+\z/i }
  validates :header_color, format: { with: /\A#([[:xdigit:]]{3}){1,2}\z/i }

  def downcase_nickname
    nickname.downcase!
  end

  def hidden?
    hidden
  end
end

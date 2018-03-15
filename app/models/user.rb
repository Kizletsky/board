class User < ApplicationRecord

  mount_uploader :avatar, ImageUploader
  validates :username, presence: true, uniqueness: true, length: {in: 3..20}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: "post"
  enum role: [ :user, :admin ]

  def calculate_average
    logger.debug "-----favorite posts: #{favorite_posts.count}"
    ratings.blank? ? 0 : ratings.map(&:value).inject(:+) / ratings.count.to_f
  end
end

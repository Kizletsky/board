class User < ApplicationRecord

  mount_uploader :avatar, ImageUploader
  validates :username, presence: true, uniqueness: true, length: {in: 3..20}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings
  has_many :rated_users, through: :ratings, class_name: "User", foreign_key: :rated_user_id
  has_many :rated_by_users, through: :ratings, class_name: "User", foreign_key: :rating_user_id
  enum role: [ :user, :admin ]

end

class User < ApplicationRecord

  mount_uploader :avatar, ImageUploader
  validates :username, presence: true, uniqueness: true, length: {in: 3..20}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  enum role: [ :user, :admin ]

end

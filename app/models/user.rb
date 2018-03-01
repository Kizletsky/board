class User < ApplicationRecord
  mount_uploader :avatar, ImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: {in: 3..20}

  has_many :posts
end

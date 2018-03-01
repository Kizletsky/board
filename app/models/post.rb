class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 50}

  belongs_to :user
end

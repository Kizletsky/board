class Tag < ApplicationRecord
  validates :name, uniqueness: true

  has_many :taggings
  has_many :posts, through: :taggings
end

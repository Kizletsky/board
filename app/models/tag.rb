# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
end

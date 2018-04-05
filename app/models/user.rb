# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :avatar, ImageUploader
  validates :username, presence: true, uniqueness: true, length: { in: 3..50 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: 'post'

  enum role: %i[user admin]

  def calculate_average
    if ratings.blank?
      0
    else
      sql = "SELECT value FROM ratings WHERE user_id = #{id}"
      values = ActiveRecord::Base.connection.execute(sql).values.sum
      values.sum / values.count.to_f
    end
  end
end

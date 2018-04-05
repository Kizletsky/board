# frozen_string_literal: true

class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  include PgSearch
  pg_search_scope :search_scope, against: %i[title body adress],
                                 associated_against: { user: :username,
                                                       tags: :name,
                                                       comments: :body }

  validates :body, presence: true, length: { maximum: 2000 }
  validates :title, presence: true, length: { maximum: 100 }
  validates :adress, length: { maximum: 100 }

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  enum status: %i[active inactive]

  def current_tags
    tags.map(&:name).map { |t| t + ',' }.join
  end

  def current_tags=(values)
    self.tags = values.split(',').map { |t| Tag.find_by(name: t) }
  end

  def self.search(keywords)
    keywords.present? ? search_scope(keywords) : all.order('created_at DESC')
  end
end

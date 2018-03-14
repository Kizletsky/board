class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 50}

  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy

  def current_tags
    tags.map(&:name).map{|t| t + ","}.join
  end

  def current_tags=(values)
    self.tags = values.split(",").map{ |t| Tag.where(name: t).first }
  end

  def self.search(keywords)
      if keywords
        joins(:user, :tags).where("lower (title) ILIKE :value OR
                            lower (body) ILIKE :value OR
                            lower (adress) ILIKE :value OR
                            lower (users.username) ILIKE :value OR
                            lower (tags.name) ILIKE :value",
        value: "%#{keywords.downcase}%").order("created_at DESC")
      else
        all.order("created_at DESC")
      end
  end
end

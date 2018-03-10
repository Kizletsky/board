class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 50}

  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy

#  def post_tags
#    tags.map(&:name).join(", ")
#  end
#
#  def post_tags=(names)
#    self.tags = names.split(", ").map{ |t| Tag.where(name: t.strip).first_or_create }
#  end
# "tag1,tag2,tag3,"
  def current_tags
    tags.map(&:name).map{|t| t + ","}.join
  end

  def current_tags=(values)
    self.tags = values.split(",").map{ |t| Tag.where(name: t).first }
    #logger.debug "SAVING HERE: "
    #logger.debug values.split(",").map{ |t| Tag.where(name: t.strip).first  }
    #values.split(",")
  end

  def self.search(keywords)
    # search by post title, body, adress, user, tags
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

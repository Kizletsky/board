# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 2000 }

  belongs_to :user
  belongs_to :post
end

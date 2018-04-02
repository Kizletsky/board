# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User'

  def self.choices
    [1, 2, 3, 4, 5]
  end
end

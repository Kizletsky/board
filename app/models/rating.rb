# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', inverse_of: :ratings
end

class Rating < ApplicationRecord
  belongs_to :rated_user, class_name: "User"
  belongs_to :rating_user, class_name: "User"
end

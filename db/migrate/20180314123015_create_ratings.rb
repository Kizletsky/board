class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer "rated_user_id"
      t.integer "rating_user_id"
      t.integer "value"
      t.timestamps
    end
      add_index("ratings",["rated_user_id", "rating_user_id"])
  end
end

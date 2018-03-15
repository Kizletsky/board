class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :user_id, index: true
      t.integer :author_id, index: true 
      t.integer :value
      t.timestamps
    end
  end
end

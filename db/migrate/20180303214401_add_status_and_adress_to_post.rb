class AddStatusAndAdressToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :status, :boolean, default: true
    add_column :posts, :adress, :string
  end
end

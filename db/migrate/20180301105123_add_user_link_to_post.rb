# frozen_string_literal: true

class AddUserLinkToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :user_id, :integer
    add_column :users, :username, :string
    add_column :users, :avatar, :string
    add_index :posts, :user_id
  end
end

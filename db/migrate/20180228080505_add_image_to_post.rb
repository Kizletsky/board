# frozen_string_literal: true

class AddImageToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :image, :string
  end
end

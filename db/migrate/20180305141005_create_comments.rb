# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer 'user_id'
      t.integer 'post_id'
      t.string 'body'
      t.timestamps
    end
    add_index('comments', %w[user_id post_id])
  end
end

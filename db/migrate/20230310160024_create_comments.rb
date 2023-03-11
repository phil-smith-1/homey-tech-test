# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :text
      t.integer :project_id

      t.timestamps
    end

    add_foreign_key :comments, :users
    add_foreign_key :comments, :projects
  end
end

# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.integer :project_id
      t.references :eventable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

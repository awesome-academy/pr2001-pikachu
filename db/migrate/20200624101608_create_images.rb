# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.references :tour, null: false, foreign_key: true
      t.string :link
      t.timestamps
    end
  end
end

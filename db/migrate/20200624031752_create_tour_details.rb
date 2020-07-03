# frozen_string_literal: true

class CreateTourDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :tour_details do |t|
      t.references :tour, null: false, foreign_key: true
      t.date :departure_time
      t.date :return_time
      t.timestamps
    end
  end
end

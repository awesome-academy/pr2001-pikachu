# frozen_string_literal: true

class CreateBookingTours < ActiveRecord::Migration[6.0]
  def change
    create_table :booking_tours do |t|
      t.references :tour_detail, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :quantity
      t.float :price_total
      t.timestamps
    end
  end
end

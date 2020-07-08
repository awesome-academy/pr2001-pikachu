# frozen_string_literal: true

class AddColumnToTours < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :coupon, :integer
    add_column :tours, :seats, :integer
  end
end

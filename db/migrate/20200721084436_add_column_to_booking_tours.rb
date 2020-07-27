class AddColumnToBookingTours < ActiveRecord::Migration[6.0]
  def change
    add_column :booking_tours, :booking_status, :integer
    add_column :booking_tours, :payment_status, :integer
  end
end

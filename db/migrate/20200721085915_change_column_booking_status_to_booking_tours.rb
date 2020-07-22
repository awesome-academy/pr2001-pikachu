class ChangeColumnBookingStatusToBookingTours < ActiveRecord::Migration[6.0]
  def change
    change_column :booking_tours, :booking_status, :integer, null: false, default: 0
    change_column :booking_tours, :payment_status, :integer, null: false, default: 0
  end
end

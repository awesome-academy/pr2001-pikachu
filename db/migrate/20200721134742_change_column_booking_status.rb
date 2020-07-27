class ChangeColumnBookingStatus < ActiveRecord::Migration[6.0]
  def change
    change_column :booking_tours, :booking_status, :integer, null: false, default: 1
  end
end

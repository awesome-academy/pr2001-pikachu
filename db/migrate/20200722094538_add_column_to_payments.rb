class AddColumnToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :tour_id, :integer
  end
end

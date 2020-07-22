class ChangeColumnCoinToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :coin, :integer, null: false, default: 0
  end
end

class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :coin, :integer
  end
end

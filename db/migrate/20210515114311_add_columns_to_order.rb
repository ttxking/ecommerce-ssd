class AddColumnsToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :amount, :integer
    add_column :orders, :product, :string
  end
end

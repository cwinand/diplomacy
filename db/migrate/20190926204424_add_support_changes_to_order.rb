class AddSupportChangesToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :support_start, :string
    add_column :orders, :support_end, :string
    add_column :orders, :support_order_type, :string
    add_column :orders, :support_order_unit_type, :string
    add_column :orders, :support_end_coast, :string
  end
end

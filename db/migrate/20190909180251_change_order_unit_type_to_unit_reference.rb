class ChangeOrderUnitTypeToUnitReference < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :unit_type
    add_reference :orders, :unit
  end
end

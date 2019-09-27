class RemoveSupportedOrderIdFromOrder < ActiveRecord::Migration[6.0]
  def change

    remove_column :orders, :supported_order_id, :number
  end
end

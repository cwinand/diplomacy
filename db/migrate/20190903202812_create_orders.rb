class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :unit_type
      t.string :start
      t.string :end
      t.string :order_type
      t.string :end_coast
      t.references :supported_order, foreign_key: { to_table: 'orders' }

      t.timestamps
    end
  end
end

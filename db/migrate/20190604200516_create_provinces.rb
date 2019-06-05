class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces, id: false do |t|
      t.string :province_code, null: false
      t.string :name
      t.string :type
      t.boolean :is_sc
      t.string :coast_1
      t.string :coast_2

      t.timestamps
    end

    add_index :provinces, :province_code, unique: true
  end
end

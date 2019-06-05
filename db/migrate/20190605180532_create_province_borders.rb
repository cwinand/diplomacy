class CreateProvinceBorders < ActiveRecord::Migration[6.0]
  def change
    create_table :province_borders do |t|
      t.string :province_code
      t.string :border_province_code
      t.string :border_coastal_code

      t.timestamps
    end
  end
end

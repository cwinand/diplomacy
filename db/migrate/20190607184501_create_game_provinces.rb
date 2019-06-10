class CreateGameProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :game_provinces do |t|
      t.references :game, null: false, foreign_key: true
      t.string :province_code, null: false, foreign_key: true
      t.string :owner

      t.timestamps
    end
  end
end

class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.string :unit_type
      t.string :current_province
      t.references :game_country, null: false, foreign_key: true

      t.timestamps
    end
  end
end

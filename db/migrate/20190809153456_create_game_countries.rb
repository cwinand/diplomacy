class CreateGameCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :game_countries do |t|
      t.references :game, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :country_code

      t.timestamps
    end
  end
end

class RemovePlayerFkFromCountry < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :game_countries, :game_players
    add_foreign_key :game_countries, :users
  end
end

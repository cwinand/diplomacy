class AddGamePlayerToGameCountry < ActiveRecord::Migration[6.0]
  def change
    add_reference :game_countries, :game_player, index: true
    add_foreign_key :game_countries, :game_players
  end
end

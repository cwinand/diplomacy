class AddConfirmedToGamePlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :game_players, :confirmed, :bool
  end
end

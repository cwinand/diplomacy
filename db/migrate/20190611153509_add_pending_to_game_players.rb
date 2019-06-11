class AddPendingToGamePlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :game_players, :pending, :bool
  end
end

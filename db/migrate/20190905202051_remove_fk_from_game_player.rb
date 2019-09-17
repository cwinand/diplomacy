class RemoveFkFromGamePlayer < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :game_players, :users
  end
end

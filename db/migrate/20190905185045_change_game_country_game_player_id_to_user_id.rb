class ChangeGameCountryGamePlayerIdToUserId < ActiveRecord::Migration[6.0]
  def change
    rename_column :game_countries, :game_player_id, :user_id
  end
end

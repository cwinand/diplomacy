class RemoveUserFromGameCountry < ActiveRecord::Migration[6.0]
  def change

    remove_column :game_countries, :user_id
  end
end

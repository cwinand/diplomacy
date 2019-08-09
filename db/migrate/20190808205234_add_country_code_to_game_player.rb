class AddCountryCodeToGamePlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :game_players, :country_code, :string
  end
end

class RemoveCountryCodeFromGamePlayer < ActiveRecord::Migration[6.0]
  def change

    remove_column :game_players, :country_code, :string
  end
end

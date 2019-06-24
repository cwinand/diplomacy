class AddWeekendSkipToGameSetting < ActiveRecord::Migration[6.0]
  def change
    add_column :game_settings, :weekend_skip, :boolean
  end
end

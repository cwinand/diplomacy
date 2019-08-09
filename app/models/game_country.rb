class GameCountry < ApplicationRecord
  belongs_to :game
  belongs_to :game_player, optional: true
end

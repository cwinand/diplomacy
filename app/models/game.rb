class Game < ApplicationRecord
  belongs_to :user
  has_many :game_provinces
  has_many :provinces, through: :game_provinces
  has_many :game_players
end

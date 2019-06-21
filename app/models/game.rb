class Game < ApplicationRecord
  belongs_to :user
  has_many :game_provinces
  has_many :provinces, through: :game_provinces
  has_many :game_players

  scope :pending, -> { where( started_at: nil ).where( ended_at: nil ) }
  scope :active, -> { where.not( started_at: nil ).where( ended_at: nil ) }
  scope :ended, -> { where.not( started_at: nil ).where.not( ended_at: nil ) }
end

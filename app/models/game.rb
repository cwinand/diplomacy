class Game < ApplicationRecord
  belongs_to :user
  has_many :game_provinces
  has_many :provinces, through: :game_provinces
  has_many :game_players
  has_many :turns
  has_many :orders, through: :turns
  has_one :game_setting
  accepts_nested_attributes_for :game_setting

  validates :name, presence: true

  after_create do
    self.game_provinces.create( Province.new_game_provinces )
  end

  scope :pending, -> { where( started_at: nil ).where( ended_at: nil ) }
  scope :active, -> { where.not( started_at: nil ).where( ended_at: nil ) }
  scope :ended, -> { where.not( started_at: nil ).where.not( ended_at: nil ) }
end

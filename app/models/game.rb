class Game < ApplicationRecord
  belongs_to :user
  has_many :game_provinces
  has_many :provinces, through: :game_provinces
  has_many :game_players
  has_many :game_countries
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

  def remaining_slots
    7 - game_players.invited_or_confirmed.count
  end

  def start
    countries = Country.all.pluck('country_code').shuffle
    confirmed_players = self.game_players.confirmed

    countries.each_with_index do |country, index|
      byebug
      player = confirmed_players[ index ]
      game_country = GameCountry.create(
        game_id: self.id,
        game_player_id: player ? player.id : nil,
        country_code: country
      )
    end

    Turn.create( game_id: self.id, year: Turn::START_YEAR, season: Turn::START_SEASON )

    self.started_at = DateTime.now
    self.save
    byebug
  end

  def advance_turn
    previous = self.turns.last

    if previous.season == 'fall'
      Turn.create( game_id: self.id, year: previous.year + 1, season: 'spring')
    else
      Turn.create( game_id: self.id, year: previous.year, season: 'fall' )
    end
  end

  def is_active
    self.started_at != nil && ended_at == nil
  end
end

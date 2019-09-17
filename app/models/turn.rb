class Turn < ApplicationRecord
  belongs_to :game
  has_many :orders

  START_YEAR = 1901
  START_SEASON = 'spring'

  after_create do
    self.game.active_units.each do |unit|
      Order.create({
        unit_id: unit.id,
        start: unit.current_province,
        order_type: 'hold',
        turn_id: self.id,
        game_country_id: unit.game_country_id
      })
    end
  end

end

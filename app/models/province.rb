class Province < ApplicationRecord
  self.primary_key = 'province_code'
  has_many :games, through: :game_provinces
end

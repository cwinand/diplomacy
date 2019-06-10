class GameProvince < ApplicationRecord
  belongs_to :game
  belongs_to :province, foreign_key: :province_code
end

class Turn < ApplicationRecord
  belongs_to :game

  START_YEAR = 1901
  START_SEASON = 'spring'

end

class GameSetting < ApplicationRecord
  belongs_to :game

  before_create do
    self.assignment_strategy = 'random'
  end

end

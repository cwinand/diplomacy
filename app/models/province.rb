class Province < ApplicationRecord
  self.primary_key = 'province_code'
  has_many :games, through: :game_provinces

  def self.new_game_provinces
    all.map do |province|
      { province_code: province.province_code, owner: province.home_of }
    end
  end

  def readonly?
    # true
  end
end

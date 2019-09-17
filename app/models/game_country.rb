class GameCountry < ApplicationRecord
  belongs_to :game
  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy
  has_many :units, dependent: :destroy

  after_create do
    provinces = Province.where(home_of: self.country_code).where('is_sc').pluck('province_code')

    provinces.each do |province|
      unit_type = STARTING_UNITS_MAP[province]
      unit = Unit.new({ unit_type: unit_type, current_province: province, game_country_id: self.id })

      if province == 'stp'
        unit.coast = 'sc'
      end

      unit.save
    end
  end

  STARTING_UNITS_MAP = {
    'ank' => 'f',
    'ber' => 'a',
    'bre' => 'f',
    'bud' => 'a',
    'con' => 'a',
    'edi' => 'f',
    'kie' => 'f',
    'lon' => 'f',
    'lvp' => 'a',
    'mar' => 'a',
    'mos' => 'a',
    'mun' => 'a',
    'nap' => 'f',
    'par' => 'a',
    'rom' => 'a',
    'sev' => 'f',
    'smy' => 'a',
    'stp' => 'f',
    'tri' => 'f',
    'ven' => 'a',
    'vie' => 'a',
    'war' => 'a'
  }

  def user_display
    return self.user ? self.user.username : 'No Player'
  end

end

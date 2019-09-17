class Unit < ApplicationRecord
  belongs_to :game_country
  has_many :order

  validates :coast, presence: true, if: :province_has_split_coast?

  def province_has_split_coast?
    !!Province.where(province_code: current_province).pluck(:coast_1).first
  end
end

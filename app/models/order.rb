class Order < ApplicationRecord
  has_one :supported_order, class_name: "Order", foreign_key: "supported_order_id"
  belongs_to :turn
  belongs_to :game_country
  belongs_to :unit

  def supported_by
    Order.where( supported_order: self.id, turn_id: self.turn_id )
  end

  def support_count
    self.supported_by.count
  end
end

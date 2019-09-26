class Order < ApplicationRecord
  has_one :supported_order, class_name: "Order", foreign_key: "supported_order_id"
  belongs_to :turn
  belongs_to :game_country
  belongs_to :unit

  def valid?
    self.order_type == 'move' && valid_move?
  end

  def valid_move?
    ProvinceBorder.where(province_code: self.start, border_province_code: self.end).count != 0
  end


  def supported_by
    Order.where( supported_order: self.id, turn_id: self.turn_id )
  end

  def support_count
    self.supported_by.count
  end
end

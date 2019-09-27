class Order < ApplicationRecord
  belongs_to :turn
  belongs_to :game_country
  belongs_to :unit

  def valid?
    case self.order_type
    when 'move'
      return valid_move?
    when 'support'
      return valid_support?
    end
  end

  def valid_move?
    border = ProvinceBorder.find_by(province_code: self.start, border_province_code: self.end)

    if !border
      return false
    end

    if self.unit.unit_type == 'f'
      # Fleet moves to a split coast need to use the correct coast
      return border.border_coastal_code && border.border_coastal_code == self.end_coast
    end

    return true
  end

  def valid_support?

  end


  def supported_by
    Order.where( supported_order: self.id, turn_id: self.turn_id )
  end

  def support_count
    self.supported_by.count
  end
end

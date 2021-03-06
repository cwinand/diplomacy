class Order < ApplicationRecord
  belongs_to :turn
  belongs_to :game_country
  belongs_to :unit

  def legal?
    case self.order_type
    when 'move'
      return legal_move?
    when 'support'
      return legal_support?
    end

    return false
  end

  def legal_move?
    border = ProvinceBorder.find_by(province_code: self.start, border_province_code: self.end)

    if !border
      return false
    end

    if self.unit.unit_type == 'f'

      # Fleet moves to a split coast need to use the correct coast
      if border.border_coastal_code &&
          border.border_coastal_code != self.end_coast &&
          border.border_coastal_code != 'both'
        return false
      end

      # Fleets can't move to land
      if Province.find_by(province_code: self.end).province_type == 'land'
        return false
      end

    elsif self.unit.unit_type == 'a'

      # Armies can't move to sea
      if Province.find_by(province_code: self.end).province_type == 'sea'
        return false
      end

    end

    return true
  end

  def legal_support?
    # Don't need to match support's coast, just if it has a border, so use the border's coast value
    border_coast = nil
    if self.unit.unit_type == 'f'
      border_coast = ProvinceBorder
        .find_by(province_code: self.support_start, border_province_code: self.support_end)
        .border_coastal_code
    end

    # Would this support be a valid move (excluding split coasts, they don't affect this check)
    legal_move = Order.new(
      start: self.start,
      end: self.support_end,
      end_coast: border_coast,
      order_type: 'move',
      unit: Unit.new(unit_type: self.unit.unit_type)
    )

    if !legal_move.legal?
      return false
    end

    # Is there an order corresponding to this support in its current turn
    if self.support_order_type === 'hold'
      corresponding = Order.where(
        start: self.support_start,
        end: self.support_end,
        order_type: self.support_order_type,
        turn: self.turn
      ).or(Order.where(
        start: self.support_start,
        end: self.support_end,
        order_type: 'support',
        turn: self.turn
      )).first
    else
      corresponding = Order.find_by(
        start: self.support_start,
        end: self.support_end,
        order_type: self.support_order_type,
        turn: self.turn
      )
    end

    return corresponding && corresponding.unit.unit_type == self.support_order_unit_type
  end


  def supported_by
    Order.where( supported_order: self.id, turn_id: self.turn_id )
  end

  def support_count
    self.supported_by.count
  end
end

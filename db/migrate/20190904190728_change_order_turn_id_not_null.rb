class ChangeOrderTurnIdNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :orders, :turn_id, false
  end
end

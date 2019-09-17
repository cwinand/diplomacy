class AddTurnReferenceToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :turn, index: true
  end
end

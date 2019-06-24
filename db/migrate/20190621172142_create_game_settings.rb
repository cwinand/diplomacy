class CreateGameSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :game_settings do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :turn_length
      t.string :assignment_strategy
      t.boolean :allow_illegal_moves

      t.timestamps
    end
  end
end

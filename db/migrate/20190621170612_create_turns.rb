class CreateTurns < ActiveRecord::Migration[6.0]
  def change
    create_table :turns do |t|
      t.references :game, null: false, foreign_key: true
      t.string :season
      t.integer :year
      t.datetime :expiration

      t.timestamps
    end
  end
end

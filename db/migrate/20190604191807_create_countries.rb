class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries, id: false do |t|
      t.string :country_code, null: false
      t.string :name

      t.timestamps
    end

    add_index :countries, :country_code, unique: true
  end
end

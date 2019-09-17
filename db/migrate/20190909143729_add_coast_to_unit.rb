class AddCoastToUnit < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :coast, :string
  end
end

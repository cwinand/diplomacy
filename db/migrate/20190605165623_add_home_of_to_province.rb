class AddHomeOfToProvince < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :home_of, :string
  end
end

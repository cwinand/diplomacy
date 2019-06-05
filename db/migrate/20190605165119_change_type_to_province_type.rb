class ChangeTypeToProvinceType < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :province_type, :string
    remove_column :provinces, :type
  end
end

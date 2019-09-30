class RemoveSupportEndCoastFromOrder < ActiveRecord::Migration[6.0]
  def change

    remove_column :orders, :support_end_coast, :string
  end
end

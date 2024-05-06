class AddColumnRecentlyAddedToQrData < ActiveRecord::Migration[7.1]
  def change
    add_column :recently_addeds, :qrType, :string
  end
end

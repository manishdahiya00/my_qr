class AddQrName < ActiveRecord::Migration[7.1]
  def change
    add_column :recently_addeds, :qr_name, :string
    add_column :qr_data, :qr_name, :string
    add_column :generated_qrs, :qr_name, :string
  end
end

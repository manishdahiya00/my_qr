class AddColumnQrTypeToQrData < ActiveRecord::Migration[7.1]
  def change
    add_column :qr_data, :qrType, :string
  end
end

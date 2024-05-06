class RemoveQrTypeFromQrData < ActiveRecord::Migration[7.1]
  def change
    remove_column :qr_data, :qrType
  end
end

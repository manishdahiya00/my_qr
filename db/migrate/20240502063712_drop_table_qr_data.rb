class DropTableQrData < ActiveRecord::Migration[7.1]
  def change
    drop_table :qr_data
  end
end

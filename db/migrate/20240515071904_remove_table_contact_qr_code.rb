class RemoveTableContactQrCode < ActiveRecord::Migration[7.1]
  def change
    drop_table :contact_qr_codes
  end
end

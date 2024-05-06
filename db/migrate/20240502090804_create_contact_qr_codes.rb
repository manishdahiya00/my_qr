class CreateContactQrCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :contact_qr_codes do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :organization
      t.string :url
      t.string :note
      t.string :device_detail_id

      t.timestamps
    end
  end
end

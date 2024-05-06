class CreateQrData < ActiveRecord::Migration[7.1]
  def change
    create_table :qr_data do |t|
      t.string :device_detail_id
      t.string :securityToken
      t.string :versionName
      t.string :versionCode
      t.string :data

      t.timestamps
    end
  end
end

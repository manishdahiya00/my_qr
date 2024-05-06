class CreateDeviceDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :device_details do |t|
      t.string :deviceId
      t.string :deviceType
      t.string :deviceName
      t.string :advertisingId
      t.string :versionName
      t.string :versionCode
      t.string :utmSource
      t.string :utmMedium
      t.string :utmTerm
      t.string :utmContent
      t.string :utmCampaign
      t.string :referrerUrl

      t.timestamps
    end
  end
end

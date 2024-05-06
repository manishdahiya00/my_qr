class CreateFavourites < ActiveRecord::Migration[7.1]
  def change
    create_table :favourites do |t|
      t.string :device_detail_id
      t.string :versionName
      t.string :versionCode
      t.string :deviceId
      t.string :qr_code_id

      t.timestamps
    end
  end
end

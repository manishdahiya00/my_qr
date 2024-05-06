class CreateUserDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :user_details do |t|
      t.string :deviceType
      t.string :deviceId
      t.string :deviceName
      t.string :socialType
      t.string :socialId
      t.string :socialToken
      t.string :socialEmail
      t.string :socialName
      t.string :socialImgUrl
      t.string :advertisingId
      t.string :versionName
      t.string :versionCode
      t.string :utmSource
      t.string :utmMedium
      t.string :utmTerm
      t.string :utmContent
      t.string :utmCampaign
      t.string :referrerUrl
      t.string :oauth_response

      t.timestamps
    end
  end
end

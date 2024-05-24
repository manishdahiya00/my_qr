class CreateRedeems < ActiveRecord::Migration[7.1]
  def change
    create_table :redeems do |t|
      t.string :user_detail_id
      t.string :mobileNumber
      t.string :payCoins
      t.string :payAmount
      t.string :payType
      t.string :versionName
      t.string :versionCode
      t.string :status,default:"PENDING"
      t.string :payVendor
      t.string :transVendor
      t.string :payId

      t.timestamps
    end
  end
end

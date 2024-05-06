class CreateGeneratedQrs < ActiveRecord::Migration[7.1]
  def change
    create_table :generated_qrs do |t|
      t.string :codeData
      t.string :codeType
      t.string :deviceId
      t.string :securityToken
      t.string :device_detail_id

      t.timestamps
    end
  end
end

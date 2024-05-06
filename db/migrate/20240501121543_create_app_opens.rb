class CreateAppOpens < ActiveRecord::Migration[7.1]
  def change
    create_table :app_opens do |t|
      t.string :deviceId
      t.string :versionName
      t.string :versionCode
      t.string :securityToken

      t.timestamps
    end
  end
end

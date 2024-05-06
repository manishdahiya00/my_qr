class CreateAppBanners < ActiveRecord::Migration[7.1]
  def change
    create_table :app_banners do |t|
      t.string :imgUrl
      t.string :actionUrl

      t.timestamps
    end
  end
end

class AddAttrStatusToAppBanner < ActiveRecord::Migration[7.1]
  def change
    add_column :app_banners, :status, :boolean,default: false
  end
end

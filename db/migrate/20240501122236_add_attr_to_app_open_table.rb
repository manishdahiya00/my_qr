class AddAttrToAppOpenTable < ActiveRecord::Migration[7.1]
  def change
    add_column :app_opens, :app_url, :string
    add_column :app_opens, :socialName, :string
    add_column :app_opens, :socialEmail, :string
    add_column :app_opens, :socialImgUrl, :string
    add_column :app_opens, :forceUpdate, :string,default: "false"
  end
end

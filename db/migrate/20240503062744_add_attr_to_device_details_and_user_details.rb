class AddAttrToDeviceDetailsAndUserDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :user_details,:device_detail_id, :string
    add_column :user_details,:advertising_id, :string
    add_column :device_details,:user_detail_id, :string,default: ""
  end
end

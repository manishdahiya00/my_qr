class CreateDeviceDetailsUserDetailsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :device_details, :user_details do |t|
      # t.index [:device_detail_id, :user_detail_id]
      # t.index [:user_detail_id, :device_detail_id]
    end
  end
end

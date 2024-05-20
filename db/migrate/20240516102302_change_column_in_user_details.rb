class ChangeColumnInUserDetails < ActiveRecord::Migration[7.1]
  def change
    rename_column :user_details, :advertising_id, :securityToken
  end
end

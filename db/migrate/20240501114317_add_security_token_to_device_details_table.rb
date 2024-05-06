class AddSecurityTokenToDeviceDetailsTable < ActiveRecord::Migration[7.1]
  def change
    add_column :device_details, :security_token, :string
    end
end

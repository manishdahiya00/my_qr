class AddDeviceDetailIdColumnToGeneratedQrsTable < ActiveRecord::Migration[7.1]
  def change
    add_column :generated_qrs, :device_detail_id,:string
  end
end

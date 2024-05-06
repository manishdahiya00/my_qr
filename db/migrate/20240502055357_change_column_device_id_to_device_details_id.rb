class ChangeColumnDeviceIdToDeviceDetailsId < ActiveRecord::Migration[7.1]
  def change
    add_column :recently_addeds , :device_detail_id, :string
  end
end

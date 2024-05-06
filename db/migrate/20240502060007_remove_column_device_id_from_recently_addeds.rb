class RemoveColumnDeviceIdFromRecentlyAddeds < ActiveRecord::Migration[7.1]
  def change
    remove_column :recently_addeds, :deviceId
  end
end

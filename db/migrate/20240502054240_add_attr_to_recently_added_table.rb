class AddAttrToRecentlyAddedTable < ActiveRecord::Migration[7.1]
  def change
    add_column :recently_addeds, :deviceId, :string
  end
end

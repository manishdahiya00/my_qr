class DropTableUserTypes < ActiveRecord::Migration[7.1]
  def change
    drop_table :device_types
  end
end

class DropTableGeneratedQrs < ActiveRecord::Migration[7.1]
  def change
    drop_table :generated_qrs
  end
end

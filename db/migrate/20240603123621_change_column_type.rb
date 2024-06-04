class ChangeColumnType < ActiveRecord::Migration[7.1]
  def change
    change_column :user_details, :socialToken, :text
  end
end

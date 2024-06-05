class ChangeColumnType < ActiveRecord::Migration[7.1]
  def up
    change_column :user_details, :socialToken, :text
    change_column :user_details, :oauth_response, :text
  end
  def down
    change_column :user_details, :socialToken, :string
    change_column :user_details, :oauth_response, :string
  end
end

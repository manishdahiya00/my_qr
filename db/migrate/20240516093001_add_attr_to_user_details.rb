class AddAttrToUserDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :user_details, :refCode, :string
  end
end

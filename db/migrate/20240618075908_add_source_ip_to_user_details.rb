class AddSourceIpToUserDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :user_details, :source_ip, :string
  end
end

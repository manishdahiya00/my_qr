class AddSourceIpToUserDetails < ActiveRecord::Migration[7.1]
  def change
    #add_column :user_details, :source_ip, :string
    change_column :recently_addeds, :subtitle, :text
  end
end

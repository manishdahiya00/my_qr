class RemoveColumnOauthResponseFromUserDetails < ActiveRecord::Migration[7.1]
  def change
    remove_column :user_details, :oauth_response
  end
end

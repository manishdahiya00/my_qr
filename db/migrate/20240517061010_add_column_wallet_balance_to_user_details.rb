class AddColumnWalletBalanceToUserDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :user_details, :wallet_balance, :integer,default: 0
  end
end

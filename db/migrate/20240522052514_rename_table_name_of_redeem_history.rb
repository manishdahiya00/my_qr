class RenameTableNameOfRedeemHistory < ActiveRecord::Migration[7.1]
  def change
    rename_table :redeem_histories, :transaction_histories
  end
end

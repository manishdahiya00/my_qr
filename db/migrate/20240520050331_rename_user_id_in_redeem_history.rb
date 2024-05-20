class RenameUserIdInRedeemHistory < ActiveRecord::Migration[7.1]
  def change
    rename_column :redeem_histories,:userId,:user_detail_id
  end
end

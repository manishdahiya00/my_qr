class CreateRedeemHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :redeem_histories do |t|
      t.string :title
      t.string :subtitle
      t.string :coins
      t.string :userId

      t.timestamps
    end
  end
end

class AddQrNameTofavourites < ActiveRecord::Migration[7.1]
  def change
    add_column :favourites, :qr_name, :string
  end
end

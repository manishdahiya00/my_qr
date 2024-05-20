class RenameDataInQrDatum < ActiveRecord::Migration[7.1]
  def change
    rename_column :qr_data,:data,:codeData
  end
end

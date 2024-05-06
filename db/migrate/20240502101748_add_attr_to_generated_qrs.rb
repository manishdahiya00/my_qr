class AddAttrToGeneratedQrs < ActiveRecord::Migration[7.1]
  def change
    add_column :generated_qrs, :versionName,:string
    add_column :generated_qrs, :versionCode,:string
  end
end

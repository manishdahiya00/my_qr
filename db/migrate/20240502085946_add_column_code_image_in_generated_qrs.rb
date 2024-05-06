class AddColumnCodeImageInGeneratedQrs < ActiveRecord::Migration[7.1]
  def change
    add_column :generated_qrs, :codeImage, :string
  end
end

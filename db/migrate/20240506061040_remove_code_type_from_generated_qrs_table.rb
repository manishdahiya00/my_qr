class RemoveCodeTypeFromGeneratedQrsTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :generated_qrs, :codeType, :string
  end
end

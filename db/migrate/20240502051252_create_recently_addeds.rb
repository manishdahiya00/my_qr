class CreateRecentlyAddeds < ActiveRecord::Migration[7.1]
  def change
    create_table :recently_addeds do |t|
      t.string :title
      t.string :subtitle

      t.timestamps
    end
  end
end

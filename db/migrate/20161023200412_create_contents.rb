class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :category
      t.integer :price
      t.timestamps
    end
  end
end

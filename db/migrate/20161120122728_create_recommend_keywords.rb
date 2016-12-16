class CreateRecommendKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :recommend_keywords do |t|
      t.string :query_keyword
      t.references :keyword, foreign_key: true
      t.string :state
      t.integer :rank

      t.timestamps
    end
  end
end

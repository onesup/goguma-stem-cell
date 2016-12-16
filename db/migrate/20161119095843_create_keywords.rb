class CreateKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :keywords do |t|
      t.string :keyword
      t.integer :query_logs_count
      t.integer :daily_query_logs_count

      t.timestamps
    end
  end
end

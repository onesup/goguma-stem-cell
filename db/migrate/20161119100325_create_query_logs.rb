class CreateQueryLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :query_logs do |t|
      t.references :keyword, foreign_key: true
      t.references :user, foreign_key: true
      t.references  :content, foreign_key: true
      t.timestamps
    end
  end
end

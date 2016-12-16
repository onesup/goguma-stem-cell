class ChangeDailyQueriesCountInKeywords < ActiveRecord::Migration[5.0]
  def change
    change_column :keywords, :daily_query_logs_count, :integer, default: 1
  end
end

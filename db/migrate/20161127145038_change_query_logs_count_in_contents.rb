class ChangeQueryLogsCountInContents < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :query_logs_count, :integer, default: 0
    add_column :contents, :daily_query_logs_count, :integer, default: 0
  end
end

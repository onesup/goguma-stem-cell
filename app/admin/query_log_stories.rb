ActiveAdmin.register Content, as: 'query_log_contents' do
  menu parent: 'keywords', label: '검색 횟수', priority: 2

  scope :query_logs
  scope :daily_query_logs

  columns = [:title, :daily_query_logs_count, :query_logs_count]
  index do
    selectable_column
    id_column
    columns.each { |i| send("column", i) }
    actions
  end
end

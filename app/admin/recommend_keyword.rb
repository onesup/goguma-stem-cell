ActiveAdmin.register RecommendKeyword do
  menu parent: 'Keywords', label: '추천 검색어', priority: 2

  columns = [:query_keyword, :keyword_id, :rank, :state]

  permit_params do
    permitted = columns
  end

  form do |f|
    f.inputs "RecommendKeyword" do
      input :query_keyword
      input :rank
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    columns.each { |i| send("column", i) }
    actions
  end

  action_item :index do
    link_to(
      '추천 검색어 재설정용 sheet 다운로드',
      excel_recommend_keywords_path(format: 'xls'),
      method: :get
    )
  end
end

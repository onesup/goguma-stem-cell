class Excel::RecommendKeywordsController < ApplicationController
  def index
    excel = RecommendKeywordExcel.new
    excel.prepare_recommend_keywords
    filename = "recommend_keyword-sheet-#{excel.date.to_s}.xlsx"
    send_data(excel.blank_sheet.to_stream.read,
                type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                filename: filename)
  end
end

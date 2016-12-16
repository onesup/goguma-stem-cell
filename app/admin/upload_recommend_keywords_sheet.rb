ActiveAdmin.register_page 'Upload Recommend Keywords Sheet' do
  menu parent: 'Keywords', label: '추천 검색어 정보 업로드', priority: 2

  content title: '추천 검색어 정보 sheet 업로드' do
    render partial: 'form'
  end

  page_action :upload, method: :post do
    unless params[:recommend_keyword]
      flash[:error] = "추천 검색어 파일을 업로드 해주세요."
      redirect_to :back and return
    end

    begin
      xlsfile = params[:recommend_keyword][:recommend_keywords].tempfile
      orig = xlsfile.path
      dest = orig + '.xls'
      File.rename orig, dest
      workbook = RubyXL::Parser.parse(dest)
    rescue Exception => e
      flash[:error] = "파일을 열지 못했습니다. -#{e.message}:"
      redirect_back(fallback_location: admin_upload_recommend_keywords_sheet_path) and return
    ensure
      File.unlink dest if dest
    end

    excel = RecommendKeywordExcel.new
    count = excel.update_from_scraped_sheet(workbook)

    flash[:notice] = "#{count} 건 입력 완료"
    redirect_back(fallback_location: admin_recommend_keywords_path) and return
  end
end

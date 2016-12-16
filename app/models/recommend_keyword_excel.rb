class RecommendKeywordExcel
  attr_accessor :date
  def initialize(date = Date.today)
    @date = date
    @recommend_keywords = recommend_keywords
    @workbook
  end

  def recommend_keywords
    RecommendKeyword.where.not(rank: nil)
  end

  def prepare_recommend_keywords

  end

  def blank_sheet
    package = Axlsx::Package.new
    package.use_shared_strings = true
    package.workbook do |wb|
      wb.add_worksheet(name: @date.to_s) do |sheet|
        blank_recommend_keywords.each do |row|
          sheet.add_row row
        end
      end
    end
    package
  end

  def columns
    columns = [:id, :query_keyword, :rank]
    columns.map(&:to_s)
  end

  def blank_recommend_keywords
    result = []
    result << columns
    blank_recommend_keywords = recommend_keywords.select(columns)
    result += extract_values blank_recommend_keywords.map(&:attributes)
    result
  end

  def edited_columns
    edited_columns = {}
    columns.each_with_index do |column, i|
      edited_columns[column] = i
    end
    unedited_columns = ['id', 'contents_providers.name', 'stories.title']
    unedited_columns.each do |column|
      edited_columns.delete(column)
    end
    edited_columns
  end

  def update_from_scraped_sheet(workbook)
    worksheet = workbook[0]
    count = 0
    worksheet.each do |row|
      if recommend_keywords.exists? row[0].value
        keywords = recommend_keywords.find(row[0].value)
        edited_columns.each do |column, i|
          keywords.send("#{column}=", row[i].value)
        end
        if keywords.save
          count += 1
        end
      else
        keywords = recommend_keywords.new
        edited_columns.each do |column, i|
          keywords.send("#{column}=", row[i].value)
        end
        if keywords.query_keyword.present? && recommend_keywords.where(query_keyword: keywords.query_keyword).empty?
          if keywords.save
            count += 1
          end
        end
      end
    end
    count
  end

  private

  def extract_values(hashes)
    result = []
    hashes.each do |attributes|
      values = []
      columns.each do |column|
        values << attributes[column.gsub(/^.+\./, '')].to_s
      end
      result << values
    end
    result
  end
end

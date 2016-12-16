class QueryLog < ApplicationRecord
  belongs_to :user

  belongs_to :keyword, counter_cache: true
  belongs_to :content, counter_cache: true

  after_create :keyword_update_daily_query_logs_count
  after_update :content_update_daily_query_logs_count

  protected

  def today_count
    today = Time.now.beginning_of_day..Time.now
    QueryLog.unscoped.where(keyword: keyword, created_at: today).count
  end

  def keyword_update_daily_query_logs_count
    keyword.update(daily_query_logs_count: today_count)
  end

  def content_update_daily_query_logs_count
    if content.present?
      content.update(daily_query_logs_count: today_count)
    end
  end
end

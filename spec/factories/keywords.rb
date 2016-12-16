FactoryGirl.define do
  factory :keyword do
    keyword "MyString"
    query_logs_count 1
    daily_query_logs_count 1
  end
end

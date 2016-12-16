FactoryGirl.define do
  factory :content do
    sequence(:title) { |n| "contents-#{n}" }
    sequence(:category_list) { |n| ['남성복', '여성복', '유아복'][n % 3] }
  end
end

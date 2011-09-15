# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@email.com" }
  end

  factory :site do
    url "http://google.com"
    user
  end
end

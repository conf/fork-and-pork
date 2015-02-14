FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test_#{n}@example.com" }
    password '12345678'
    calories 200
  end
end

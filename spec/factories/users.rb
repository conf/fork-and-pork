FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test_#{n}.example.com" }
  end
end

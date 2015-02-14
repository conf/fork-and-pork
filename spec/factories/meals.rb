FactoryGirl.define do
  factory :meal do
    details "Apple"
    calories 200
    created_at { Time.current }
    user
  end

end

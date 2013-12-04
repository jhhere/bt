FactoryGirl.define do
  factory :user do
    sequence (:email) { |n| "person_#{n}@example.com"}
    password "password"
    password_confirmation "password"
  end
  factory :goal do
    goal "I want to make 300 recipes in 365 days"
    user
  end
end
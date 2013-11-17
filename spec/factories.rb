FactoryGirl.define do
  factory :goal do
    goal "I want to make 300 recipes in 365 days"
  end

  factory :user do
    email "example@example.com"
    password "password"
    password_confirmation "password"
  end
end
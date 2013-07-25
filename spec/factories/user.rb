FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}"}
    first_name "example"
    last_name "user"
    sequence(:email) { |n| "example#{n}@example.com"}
    password "password"
  end
end

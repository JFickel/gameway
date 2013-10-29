FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "example#{n}"}
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email { "#{username}@example.com" }
    password "password"
  end
end

FactoryGirl.define do
  sequence :username do |n|
    "example#{n}"
  end
  factory :user do
    username
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email { "#{username}@example.com" }
    password "password"
  end
end

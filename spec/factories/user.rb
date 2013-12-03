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

    after(:build) { |user| user.class.skip_callback(:create, :after, :set_gravatar_as_default) }
    after(:create) { |user| user.class.set_callback(:create, :after, :set_gravatar_as_default) }
  end
end

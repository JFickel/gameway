FactoryGirl.define
  factory :contact
    sequence(:username) { |n| "user#{n}"}
    first_name "example"
    last_name "user"
    sequence(:email) { |n| "example#{n}@example.com"}
  end
end

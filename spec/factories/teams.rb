# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    sequence(:name) {|n| "Team#{n}"}
    association :leader, factory: :user

    ignore do
      users_count 10
    end

    trait :with_users do
      after :create do |team, evaluator|
        evaluator.users_count.times do |i|
          FactoryGirl.create_list :team_membership, user: create(:user), team: team
        end
      end
    end

    after(:build) { |team| team.class.skip_callback(:create, :before, :set_gravatar_as_default) }
    after(:create) { |team| team.class.set_callback(:create, :before, :set_gravatar_as_default) }
  end
end

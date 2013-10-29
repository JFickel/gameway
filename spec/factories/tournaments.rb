# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tournament do
    sequence(:title) {|n| "Tournament#{n}"}
    game 'League of Legends'
    start_date '2013-11-5'
    start_hour '9'
    start_minute '00'
    start_period 'pm'
    association :owner, factory: :user

    ignore do
      teams_count 0 ## These don't matter in my setup because evaluator#teams_count will return a hash which you can't call #times on
      users_count 0
    end

    trait :with_teams do
      mode 'team'

      after :create do |tournament, evaluator|
        evaluator.teams_count.times do |i|
          create(:tournament_membership, team: create(:team), tournament: tournament)
        end
      end
    end


    trait :with_users do
      mode 'individual'

      after :create do |tournament, evaluator|
        evaluator.users_count.times do |i|
          create(:tournament_membership, user: create(:user), tournament: tournament)
        end
      end
    end
  end
end

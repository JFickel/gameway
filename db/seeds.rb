# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
t = Tournament.create(title: "Team Liquid October Invitational",
                  game: "Starcraft 2: Heart of the Swarm",
                  starts_at: DateTime.current + 45.seconds,
                  user_id: 1,
                  description: 'Some of the biggest names in Starcraft 2 come to compete in this monthly tournament held by Team Liquid.')

58.times do |i|
  u = User.create(username: "test.username#{i}",
              first_name: "first#{i}",
              last_name: "last#{i}",
              email: "example#{i}@example.com",
              password: "password")
  t.tournament_memberships << TournamentMembership.new(user_id: u.id)
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
sc2 = Tournament.create(title: "Team Liquid October Invitational",
                  game: "Starcraft 2: Heart of the Swarm",
                  start_date: "2013-11-15",
                  start_hour: "3",
                  start_minute: "30",
                  start_period: "pm",
                  mode: "individual",
                  open: true,
                  user_id: 1,
                  description: 'Some of the biggest names in Starcraft 2 come to compete in this monthly tournament held by Team Liquid.')

58.times do |i|
  u = User.create(username: "test.username#{i}",
              first_name: "first#{i}",
              last_name: "last#{i}",
              email: "example#{i}@example.com",
              password: "password")
  sc2.tournament_memberships << TournamentMembership.new(user_id: u.id)
end

24.times do |i|
  t = Team.create(name: "Test Team#{i}",
                  leader: User.find(i+1))
end


lol = Tournament.create(title: 'TeSPA Lone Star Clash 3',
                        game: 'League of Legends',
                        start_date: "2013-11-15",
                        start_hour: "7",
                        start_minute: "00",
                        start_period: "pm",
                        mode: "individual",
                        open: false,
                        open_applications: false,
                        user_id: 2,
                        description: '16 teams from Texas compete in the third Lone Star Clash put on by TeSPA')

lolopen = Tournament.create(title: 'Collegiate Gaming League Open',
                            game: 'League of Legends',
                            start_date: "2013-11-22",
                            start_hour: "6",
                            start_minute: "00",
                            start_period: "pm",
                            mode: "team",
                            open: true,
                            open_applications: false,
                            user_id: 1,
                            description: 'Collegiate Gaming league is hosting an open tournament for teams affiliated with colleges.')
24.times do |i|
  lolopen.tournament_memberships << TournamentMembership.new(team_id: i+1)
end

16.times do |i|
  lol.tournament_memberships << TournamentMembership.new(user_id: i+3)
end

cloud9 = Team.create(name: 'Cloud 9')
hai = User.create(username: "hai",
                  first_name: "Hai",
                  last_name: "Lam",
                  email: "hai@example.com",
                  password: "password")
meteos = User.create(username: "meteos",
                    first_name: "Will",
                    last_name: "Hartman",
                    email: "meteos@example.com",
                    password: "password")
balls = User.create(username: "balls",
                    first_name: "An",
                    last_name: "Van Lee",
                    email: "balls@example.com",
                    password: "password")
cloud9.leader = hai
cloud9.users.push hai, meteos, balls, User.first
cloud9.save

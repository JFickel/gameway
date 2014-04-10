# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Game.where(name: 'League of Legends',
                    technical_name: 'lol',
                    description: 'League of Legends is a fast-paced, competitive online game that blends the speed and intensity of an RTS with RPG elements. Two teams of powerful champions, each with a unique design and playstyle, battle head-to-head across multiple battlefields and game modes.'
          ).first_or_create


user = User.new(email: 'example@example.com',
                password: 'password',
                password_confirmation: 'password')
user.skip_confirmation!
user.save

(1..15).each do |num|
  user = User.new(email: 'example#{num}@example.com',
                  password: 'password',
                  password_confirmation: 'password')
  user.skip_confirmation!
  user.save
end

tournament = Tournament.create(name: 'Another Tournament', description: 'This is a test tournament', lol_region: 'na')

team_names = ['Baltimore Ravens', 'Chicago Bears', 'Cincinatti Bengals', 'Detroit Lions',
              'Cleveland Browns', 'Green Bay Packers', 'Pittsburgh Steelers', 'Minnesota Vikings',
              'Houston Texas', 'Atlanta Falcons', 'Indianapolis Colts', 'Carolina Panthers',
              'Jacksonville Jaguars', 'New Orleans Saints', 'Tennessee Titans', 'Tampa Bay Buccaneers']

team_names.each.with_index do |name, index|
  Team.create(name: name, lol_region: 'na', user_id: index+1)
end

tournament.teams.push Team.all

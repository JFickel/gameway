class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.text :description
      t.date :starts_at # Will I need Sidekiq for this?
      t.boolean :started, default: false
      t.boolean :ended, default: false
      t.integer :user_id
      t.string :lol_region
      t.integer :game_id
      t.string :bracket_id # This id is a string because it corresponds to a bracket stored in Firebase

      t.timestamps
    end
  end
end

# Possibly add a tournament game configuration model in the future if we support more games

# bracket:
# structure: [
#   [Match, Match, Match],
#   [Match, Match, Match],
#   [Match, Match, Match],
# ]
# tournament_id: integer
# game_id: integer

# PATCH bracket
# bracket#update
# advance: {
  # round: integer
  # match_id: integer
  # team_id: integer
  # user_id: integer
# }

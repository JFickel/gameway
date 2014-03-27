class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.text :description
      t.date :starts_at # Will I need Sidekiq for this?
      t.boolean :started

      t.timestamps
    end
  end
end

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

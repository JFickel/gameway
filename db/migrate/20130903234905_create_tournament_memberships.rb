class CreateTournamentMemberships < ActiveRecord::Migration
  def change
    create_table :tournament_memberships do |t|
      t.belongs_to :team
      t.belongs_to :tournament
      t.belongs_to :user
      t.timestamps
    end
  end
end

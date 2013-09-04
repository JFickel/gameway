class CreateTournamentMembers < ActiveRecord::Migration
  def change
    create_table :tournament_members do |t|
      t.belongs_to :tournament
      t.belongs_to :user
      t.timestamps
    end
  end
end

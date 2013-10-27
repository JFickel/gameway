class CreateTeamShowings < ActiveRecord::Migration
  def change
    create_table :team_showings do |t|
      t.belongs_to :team
      t.belongs_to :match
      t.boolean :top
      t.timestamps
    end
  end
end

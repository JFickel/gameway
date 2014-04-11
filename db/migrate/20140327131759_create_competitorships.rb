class CreateCompetitorships < ActiveRecord::Migration
  def change
    create_table :competitorships do |t|
      t.integer :tournament_id
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
  end
end

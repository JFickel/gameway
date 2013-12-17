class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|

      t.integer :affiliate_team_id
      t.integer :affiliated_tournament_id
      t.integer :affiliated_team_id
      t.integer :affiliated_group_id

      t.timestamps
    end
  end
end

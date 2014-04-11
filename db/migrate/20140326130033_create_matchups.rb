class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.integer :match_id
      t.integer :user_id
      t.integer :team_id
      t.boolean :top

      t.timestamps
    end
  end
end

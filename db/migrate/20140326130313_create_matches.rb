class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :next_matchup_id
      t.integer :index
      t.integer :round_id

      t.timestamps
    end
  end
end

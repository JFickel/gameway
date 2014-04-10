class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :next_matchup_id
      t.integer :bracket_id

      t.timestamps
    end
  end
end

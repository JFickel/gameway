class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :next_match_up_id
      t.integer :round_index
      t.integer :bracket_id

      t.timestamps
    end
  end
end

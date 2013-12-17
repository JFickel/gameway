class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :next_match_id
      t.belongs_to :tournament
      t.timestamps
    end
  end
end

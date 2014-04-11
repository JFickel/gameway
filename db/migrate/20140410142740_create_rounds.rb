class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :index
      t.integer :bracket_id
      t.timestamps
    end
  end
end

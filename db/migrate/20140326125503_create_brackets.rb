class CreateBrackets < ActiveRecord::Migration
  def change
    create_table :brackets do |t|
      t.text :structure
      t.integer :tournamnent_id
      t.integer :game_id
      t.string :mode
      t.string :game

      t.timestamps
    end
  end
end

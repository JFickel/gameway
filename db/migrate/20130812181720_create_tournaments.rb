class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :title
      t.string :game
      t.text :description
      t.text :rules
      t.datetime :starts_at
      t.text :bracket
      t.belongs_to :user
      t.boolean :started
      t.boolean :open
      t.boolean :open_applications
      t.integer :maximum_participants
      t.timestamps
    end
  end
end

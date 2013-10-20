class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :title
      t.string :game
      t.datetime :starts_on
      t.text :bracket
      t.belongs_to :user
      t.boolean :started
      t.timestamps
    end
  end
end

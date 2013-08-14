class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :title
      t.string :game
      t.datetime :start_time
      t.belongs_to :user
      t.timestamps
    end
  end
end

class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :technical_name
      t.string :description

      t.timestamps
    end
  end
end

class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.text :body
      t.belongs_to :user
      t.belongs_to :team
      t.belongs_to :tournament
      t.timestamps
    end
  end
end

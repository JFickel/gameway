class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :starts_at
      t.datetime :ends_at
      t.belongs_to :team
      t.belongs_to :group
      t.belongs_to :user

      t.timestamps
    end
  end
end

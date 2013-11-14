class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.text :introduction
      t.boolean :open_applications, default: true
      # t.boolean :partner #
      t.belongs_to :user
      t.timestamps
    end
  end
end

class CreateStarcraft2Accounts < ActiveRecord::Migration
  def change
    create_table :starcraft2_accounts do |t|
      t.string :url
      t.string :host
      t.string :locale
      t.integer :realm
      t.string :character_name
      t.integer :profile_id
      t.belongs_to :user

      t.timestamps
    end
  end
end

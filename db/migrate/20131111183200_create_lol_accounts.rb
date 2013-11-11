class CreateLolAccounts < ActiveRecord::Migration
  def change
    create_table :lol_accounts do |t|
      t.string :summoner_name
      t.belongs_to :user

      t.timestamps
    end
  end
end

class CreateLolAccounts < ActiveRecord::Migration
  def change
    create_table :lol_accounts do |t|
      t.integer :user_id
      t.integer :summoner_id
      t.string :summoner_name
      t.string :solo_tier
      t.string :solo_rank
      t.string :region
    end
  end
end

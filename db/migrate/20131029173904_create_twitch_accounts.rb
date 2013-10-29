class CreateTwitchAccounts < ActiveRecord::Migration
  def change
    create_table :twitch_accounts do |t|
      t.string :username
      t.string :stream_url
      t.belongs_to :user

      t.timestamps
    end
  end
end

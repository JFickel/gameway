class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.belongs_to :user
      t.string     :provider
      t.string     :uid
      t.string     :token
      t.string     :token_secret
    end
  end
end

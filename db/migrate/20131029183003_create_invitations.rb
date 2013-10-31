class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.text :message
      t.integer :sender_id
      t.string :role
      t.belongs_to :user
      t.belongs_to :tournament
      t.belongs_to :team
      t.timestamps
    end
  end
end

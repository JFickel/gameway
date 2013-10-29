class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.text :message
      t.belongs_to :user
      t.belongs_to :tournament
      t.belongs_to :team
      t.timestamps
    end
  end
end

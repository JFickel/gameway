class CreateBroadcasterRoles < ActiveRecord::Migration
  def change
    create_table :broadcaster_roles do |t|
      t.belongs_to :tournament
      t.belongs_to :user

      t.timestamps
    end
  end
end

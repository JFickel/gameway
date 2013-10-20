class CreateModeratorRoles < ActiveRecord::Migration
  def change
    create_table :moderator_roles do |t|
      t.belongs_to :tournament
      t.belongs_to :user
    end
  end
end

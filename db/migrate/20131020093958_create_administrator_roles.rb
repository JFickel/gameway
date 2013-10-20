class CreateAdministratorRoles < ActiveRecord::Migration
  def change
    create_table :administrator_roles do |t|
      t.belongs_to :tournament
      t.belongs_to :user
    end
  end
end

class CreateUserShowings < ActiveRecord::Migration
  def change
    create_table :user_showings do |t|
      t.belongs_to :user
      t.belongs_to :match
      t.timestamps
    end
  end
end

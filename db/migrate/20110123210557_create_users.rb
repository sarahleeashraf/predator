class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :hashed_password
      t.string :salt
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
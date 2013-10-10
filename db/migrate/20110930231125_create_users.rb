class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer  :user_api_id
      t.string   :first_name
      t.string   :last_name
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index :users, :user_api_id
  end

  def self.down
    remove_index :users, :user_api_id
    drop_table :users
  end
end

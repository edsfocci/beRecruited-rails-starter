class CreateFavorites < ActiveRecord::Migration
  def self.up
    create_table :favorites do |t|
      t.integer  :user_api_id
      t.integer  :team_api_id
      t.integer  :current_amount
      t.integer  :last_week_amount

      t.timestamps
    end

    add_index :favorites, :team_api_id
    add_index :favorites, [:user_api_id, :team_api_id]
    add_index :favorites, :user_api_id
  end

  def self.down
    remove_index :favorites, :team_api_id
    remove_index :favorites, [:user_api_id, :team_api_id]
    remove_index :favorites, :user_api_id
    drop_table :favorites
  end
end

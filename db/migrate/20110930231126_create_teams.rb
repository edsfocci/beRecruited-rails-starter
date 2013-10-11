class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.integer  :team_api_id
      t.string   :location
      t.string   :nickname

      t.timestamps
    end

    add_index :teams, :team_api_id
  end

  def self.down
    remove_index :teams, :team_api_id
    drop_table :teams
  end
end

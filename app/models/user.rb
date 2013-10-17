class User < ActiveRecord::Base
  attr_accessible :user_api_id, :first_name, :last_name

  # DONE: Define the relationship to teams and/or favorites
  has_many(
    :outgoing_favorites,
    class_name: 'Favorite',
    foreign_key: :user_api_id,
    primary_key: :user_api_id
  )
  has_many :favorite_teams, through: :outgoing_favorites, source: :team
end

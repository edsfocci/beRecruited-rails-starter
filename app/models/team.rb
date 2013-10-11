class Team < ActiveRecord::Base
  attr_accessible :team_api_id, :location, :nickname

  # TODO: Define the relationship to users and/or favorites
  has_many(
    :incoming_favorites,
    class_name: 'Favorite',
    foreign_key: :team_api_id,
    primary_key: :team_api_id
  )

  has_many :favorited_users, through: :incoming_favorites, source: :user
end

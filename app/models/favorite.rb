class Favorite < ActiveRecord::Base
  attr_accessible :user_api_id, :team_api_id, :current_amount, :last_week_amount

  # TODO: Define the relationship to users and/or teams
  belongs_to(
    :user,
    foreign_key: :user_api_id
    primary_key: :user_api_id
  )

  belongs_to(
    :team,
    foreign_key: :team_api_id
    primary_key: :team_api_id
  )

  def self.top(team, limit = TOP_LIMIT)
    # TODO: Given a team, return the top n users
    favs = team.incoming_favorites.includes(:user)

    users_points_sorted = []
    users_points_sorted = favs do |fav|
      user = fav.user

      user_hash = { name: user.first_name + ' ' + user.last_name,
                    current_amount: fav.current_amount,
                    last_week_amount: fav.last_week_amount }

      users_points_sorted =
                        self.binary_sort_insert(user_hash, users_points_sorted)
    end

    users_points_sorted[0..limit]
  end

  def self.binary_sort_insert(user_hash, array)
    dup_array = array.dup

    if array.size == 0
      return dup_array << user_hash
    elsif user_hash['current_amount'] < array.last['current_amount']
      return dup_array << user_hash
    elsif user_hash['current_amount'] > array.first['current_amount']
      return dup_array.unshift(user_hash)
    end

    top, middle, bottom = 0, array.size / 2, array.size - 1

    until user_hash['current_amount'] < array.[middle - 1]['current_amount'] &&
              user_hash['current_amount'] > array.[middle]['current_amount']
      if user_hash['current_amount'] > array.[middle - 1]['current_amount']
        bottom = middle
      else
        top = middle
      end

      middle = array[top..bottom].size / 2
    end

    dup_array.insert(middle, user_hash)
  end
end

TOP_LIMIT = 5

class Favorite < ActiveRecord::Base
  attr_accessible :user_api_id, :team_api_id, :current_amount, :last_week_amount

  # DONE: Define the relationship to users and/or teams
  belongs_to(
    :user,
    foreign_key: :user_api_id,
    primary_key: :user_api_id
  )

  belongs_to(
    :team,
    foreign_key: :team_api_id,
    primary_key: :team_api_id
  )

  # Note: can do the same thing as below for top 5 with the following SQL query:
  # Therefore if possible, I would have the below method in controller instead
  # Example is for Buccaneers: db ID 1 (teams.id)

  # SELECT users.first_name, users.last_name,
  # favorites.current_amount, favorites.last_week_amount
  # FROM teams INNER JOIN favorites
  # ON (teams.team_api_id = favorites.team_api_id)
  # INNER JOIN users
  # ON (favorites.user_api_id = users.user_api_id)
  # WHERE teams.id = 1
  # ORDER BY favorites.current_amount DESC LIMIT 5;
  def self.top(team, limit = TOP_LIMIT)
    # TODO: Given a team, return the top n users
    favs = team.incoming_favorites.includes(:user)

    users_points_sorted = []
    favs.each do |fav|
      user = fav.user

      user_hash = { name: user.first_name + ' ' + user.last_name,
                    current_amount: fav.current_amount,
                    last_week_amount: fav.last_week_amount }

      users_points_sorted =
                        self.binary_sort_insert(user_hash, users_points_sorted)
    end

    users_points_sorted[0...limit]
  end

  def self.binary_sort_insert(user_hash, array)
    dup_array = array.dup

    if array.size == 0
      return dup_array << user_hash
    elsif user_hash[:current_amount] <= array.last[:current_amount]
      if self.needs_to_swap?(user_hash, array.last, :up)
        return dup_array.insert(dup_array.size - 1, user_hash)
      else
        return dup_array << user_hash
      end
    elsif user_hash[:current_amount] >= array.first[:current_amount]
      if self.needs_to_swap?(user_hash, array.first, :down)
        return dup_array.insert(1, user_hash)
      else
        return dup_array.unshift(user_hash)
      end
    end

    top, middle, bottom = 0, array.size / 2, array.size - 1

    until user_hash[:current_amount] <= array[middle - 1][:current_amount] &&
              user_hash[:current_amount] >= array[middle][:current_amount]
      if user_hash[:current_amount] > array[middle - 1][:current_amount]
        bottom = middle
      else
        top = middle
      end

      middle = (array[top..bottom].size / 2) + top
    end

    # Edge case: Users with the same current_amount:
      # put in order of last_week_amount
      # Note: designed for this coding challenge only (only 1 with same amount)
    # if user_hash[:current_amount] == array[middle - 1][:current_amount]
    #   if user_hash[:last_week_amount] > array[middle - 1][:last_week_amount]
    #     middle -= 1
    #   end
    # elsif user_hash[:current_amount] == array[middle][:current_amount]
    #   if user_hash[:last_week_amount] < array[middle][:last_week_amount]
    #     middle += 1
    #   end
    # end

    if self.needs_to_swap?(user_hash, array[middle - 1], :up)
      middle -= 1
    elsif self.needs_to_swap?(user_hash, array[middle], :down)
      middle += 1
    end

    dup_array.insert(middle, user_hash)
  end


  # Edge case: Users with the same current_amount:
    # put in order of last_week_amount
    # Note: designed for this coding challenge only (only 1 with same amount)
  def self.needs_to_swap?(hash1, hash2, direction)
    if hash1[:current_amount] == hash2[:current_amount]
      if direction == :up &&
                            hash1[:last_week_amount] > hash2[:last_week_amount]
        return true
      elsif hash1[:last_week_amount] < hash2[:last_week_amount]
        return true
      end
    end

    false
  end
end

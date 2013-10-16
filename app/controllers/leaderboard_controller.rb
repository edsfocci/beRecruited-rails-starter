class LeaderboardController < ApplicationController
  def index
    if Team.all.empty?
      populate_this_db_with_berecruited_db
    end

    # Log counts in server log (debug)
    # p 'Teams:     ' + Team.all.size.to_s
    # p 'Users:     ' + User.all.size.to_s
    # p 'Favorites: ' + Favorite.all.size.to_s



    respond_to do |format|
      format.html { render :index }
      format.json {
        @team = Team.find(params[:id])
        @favorites = @team.incoming_favorites.includes(:user)
        @leaders = @favorites.map { |favorite| favorite.user }
        render :json => { users: @leaders, favorites: @favorites }
      }
    end

    # TODO: Fetch team based on dropdown selection 
    # @team = ?

    # TODO: Fetch top 5 leaders for this team
    # @leaders = ?
  end

  API_URL_HASH = {    'team' => "http://br-interview-api.heroku.com/teams",
                      'user' => "http://br-interview-api.heroku.com/users",
                  'favorite' => "http://br-interview-api.heroku.com/favorites" }

  def populate_this_db_with_berecruited_db
    API_URL_HASH.each do |key, url|
      json_res = JSON.parse(RestClient.get(url))

      json_res.each do |entry|
        case key
        when 'team'
          team_hash = {}
          team_hash[:team_api_id] = entry[key]['id']
          team_hash[:location] = entry[key]['address']
          team_hash[:nickname] = entry[key]['nick']

          Team.create(team_hash)
        when 'user'
          user_hash = {}
          user_hash[:user_api_id] = entry[key]['id']
          user_hash[:first_name] = entry[key]['first_name']
          user_hash[:last_name] = entry[key]['last_name']

          User.create(user_hash)
        when 'favorite'
          fav_hash = {}
          fav_hash[:user_api_id] = entry[key]['user_id']
          fav_hash[:team_api_id] = entry[key]['team_id']
          fav_hash[:current_amount] = entry[key]['current_points']
          fav_hash[:last_week_amount] = entry[key]['last_week_points']

          Favorite.create(fav_hash)
        end
      end
    end
  end
end

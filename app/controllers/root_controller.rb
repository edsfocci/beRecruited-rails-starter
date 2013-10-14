class RootController < ApplicationController
  def root
    redirect_to leaderboard_index_url
  end
end

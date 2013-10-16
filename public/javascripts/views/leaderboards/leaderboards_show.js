Leaderboard.Views.LeaderboardsShow = Backbone.View.extend({
  render: function () {
    var that = this;
    $('#team_name').html(this.model.escape('nickname') + ' ');
    $('title').html(this.model.escape('nickname') + ' Leaderboard');

    // TODO: Must change according to specs in leaderboard_controller.rb
    $.ajax({
      url: '/leaderboard.json',
      type: 'GET',
      data: { 'id': this.model.id },
      success: function (combinedData) {
        var usersData = combinedData['users'].map(function(userData) {
          return userData['user'];
        });

        var favsData = combinedData['favorites'].map(function(favData) {
          return favData['favorite'];
        });

        that.users = new Leaderboard.Collections.Users(usersData);
        that.favorites = new Leaderboard.Collections.Favorites(favsData);

        that.$el.html(_.template($('#top_five_template').html())({
          users: that.users,
          favorites: that.favorites
        }));
      }
    });
    return this;
  }
});
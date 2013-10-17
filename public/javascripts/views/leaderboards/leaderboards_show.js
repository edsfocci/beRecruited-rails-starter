Leaderboard.Views.LeaderboardsShow = Backbone.View.extend({
  render: function () {
    var that = this;
    $('#team_name').html(this.model.escape('nickname') + ' ');
    $('title').html(this.model.escape('nickname') + ' Leaderboard');

    $.ajax({
      url: '/leaderboard.json',
      type: 'GET',
      data: { 'id': this.model.id },
      success: function (combinedData) {
        // var usersData = combinedData['users'];
        var leadsData = combinedData['leaders'];

        // that.users = new Leaderboard.Collections.Users(usersData);
        that.leaders = new Leaderboard.Collections.Leaders(leadsData);

        that.$el.html(_.template($('#top_five_template').html())({
          leaders: that.leaders
        }));

        // $('#all_users').html(_.template($('#all_users_template').html())({
        //   users: that.users
        // }));
      }
    });
    return this;
  }
});
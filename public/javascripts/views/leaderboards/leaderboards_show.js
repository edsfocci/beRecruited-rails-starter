Leaderboard.Views.LeaderboardsShow = Backbone.View.extend({
  events: {
    "change select": "redirect"
  },

  render: function () {
    var that = this;
    $('#team_name').html(that.model.escape('nickname') + ' ');
    $('title').html(that.model.escape('nickname') + ' Leaderboard');

    // TODO: Must change according to specs in leaderboard_controller.rb
    // $.ajax(
    //   url: '/leaderboard/' + id,
    //   type: 'GET',
    //   success: function (usersData_unclean) {
    //     var usersData = usersData_unclean.map(function(userData) {
    //       userData['user'];
    //     });

    //     this.collection: new Leaderboard.Collections.Users({
    //       usersData
    //     });

    //     this.$el.html(_.template($('#top_five_template').html())({
    //       users: this.collection
    //     }));
    //   }
    // );
    return this;
  },

  redirect: function (event) {
    var id = 
          event.currentTarget.options[event.currentTarget.selectedIndex].value;
    //window.location.hash = id;
    Backbone.history.navigate("#/" + id);
  }
});
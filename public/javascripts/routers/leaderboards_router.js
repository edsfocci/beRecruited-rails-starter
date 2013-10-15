Leaderboard.Routers.Leaderboards = Backbone.Router.extend({
  initialize: function ($rootEl, teams) {
    this.$rootEl = $rootEl;
    this.teams = teams;
  },

  routes: {
    '': 'index',
    ':id': 'show'
  },

  index: function () {
    var leaderboardsIndex = new Leaderboard.Views.LeaderboardsIndex({
      collection: this.teams
    });
    $('#teams_dropdown').html(leaderboardsIndex.render().$el);
  },

  show: function () {
    var leaderboardsShow = new Leaderboard.Views.LeaderboardsShow({
      collection: this.users
    });

    this.$rootEl.html(leaderboardsShow.render().$el);
  }
});

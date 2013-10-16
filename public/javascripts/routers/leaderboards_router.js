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

  show: function (id) {
    var team = this.teams.get(id);
    var leaderboardsShow = new Leaderboard.Views.LeaderboardsShow({
      model: team
    });

    this.$rootEl.html(leaderboardsShow.render().$el);
  }
});

Leaderboard.Routers.Leaderboards = Backbone.Router.extend({
  initialize: function ($rootEl, teams) {
    this.$rootEl = $rootEl;
    this.teams = teams;
  },

  routes: {
    'leaderboard': 'index',
    'leaderboard/:id': 'show'
  },

  index: function () {
    var leaderboardsIndex = new Leaderboard.Views.LeaderboardsIndex({
      collection: this.teams
    });
    this.$('#teams_dropdown').html(leaderboardsIndex.render().$el);
  },

  show: function () {
    var leaderboardsNew = new Leaderboard.Views.LeaderboardsShow({
      collection: this.products
    });

    this.$rootEl.html(productsNew.render().$el);
  }
});

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
    this.layout();
  },

  show: function (id) {
    if($('#teams_dropdown').html().length === 3) {
      this.layout();
      $('[value="' + id + '"]').attr('selected', 'selected');
    }
    else {
      $('[selected="selected"]').removeAttr('selected');
      $('[value="' + id + '"]').attr('selected', 'selected');
    }

    var team = this.teams.get(id);
    var leaderboardsShow = new Leaderboard.Views.LeaderboardsShow({
      model: team
    });

    this.$rootEl.html(leaderboardsShow.render().$el);
  },

  /** Helper functions **/
  layout: function () {
    var leaderboardsLayout = new Leaderboard.Views.LeaderboardsLayout({
      collection: this.teams
    });
    $('#teams_dropdown').html(leaderboardsLayout.render().$el);
  }
});

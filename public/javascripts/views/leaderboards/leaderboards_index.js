Leaderboard.Views.LeaderboardsIndex = Backbone.View.extend({
  render: function () {
    this.$el.html(_.template($('#team_dropdown_template').html())({
      teams: this.collection
    }));
    return this;
  }
});
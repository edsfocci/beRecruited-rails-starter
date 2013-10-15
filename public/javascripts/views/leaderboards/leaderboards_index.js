Leaderboard.Views.LeaderboardsIndex = Backbone.View.extend({
  render: function () {
    this.$el.html(this.template({
      products: this.collection
    }));
    return this;
  },
});
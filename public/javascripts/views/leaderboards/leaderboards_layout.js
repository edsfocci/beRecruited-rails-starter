Leaderboard.Views.LeaderboardsLayout = Backbone.View.extend({
  // TODO: Find out why this isn't working
  // template: _.template($('#team-dropdown-template').html()),

  events: {
    "change select": "redirect"
    // "click option": "redirect"
  },

  render: function () {
    this.$el.html(_.template($('#team_dropdown_template').html())({
      teams: this.collection
    }));

    $('.all_users').empty();
    return this;
  },

  redirect: function (event) {
    var id = event.currentTarget.value;
    if(id !== '') {
      Backbone.history.navigate("#/" + id);
    }
  }
});
Leaderboard.Views.LeaderboardsIndex = Backbone.View.extend({
  events: {
    "change select": "redirect"
  },

  render: function () {
    this.$el.html(_.template($('#team_dropdown_template').html())({
      teams: this.collection
    }));
    return this;
  },

  redirect: function (event) {
    var id = 
          event.currentTarget.options[event.currentTarget.selectedIndex].value;
    if(id !== '') {
      Backbone.history.navigate("#/" + id);
    }
  }
});
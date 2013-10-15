// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
window.Leaderboard = {
  // we'll eventually store Backbone classes inside of these namespaces
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function ($rootEl, teamsData) {
    var teams = new Leaderboard.Collections.Teams(teamsData);

    new Leaderboard.Routers.Leaderboards($rootEl, teams);
    Backbone.history.start();
  }
};
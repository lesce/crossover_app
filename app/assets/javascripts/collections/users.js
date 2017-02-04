var Users = Backbone.Collection.extend({
  url: '/api/v1/users',

  parse: function(response) {
    return response.users;
  }
});

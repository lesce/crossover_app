var User = Backbone.Model.extend({
  urlRoot: '/api/v1/users',

  parse: function(response) {
    return response.user;
  },

  toJSON: function() {
    return { user: this.attributes };
  }
});

var TicketsView = Backbone.View.extend({

  el: "#main",

  events: {
    'click .users': 'goToUsers',
    'click .signout': 'signout',
    'click .create-ticket': 'create',
  },

  goToUsers: function(e) {
    e.preventDefault();
    app.navigate('users', { trigger: true});
  },

  signout: function(e) {
    e.preventDefault();
    localStorage.removeItem('email');
    localStorage.removeItem('auth_token');
    app.navigate('login', { trigger: true});
  },

  create: function(e) {
    e.preventDefault();
  },

  render: function() {
    var template = Handlebars.compile($('#tickets').html());
    this.$el.html(template(this.collection));
  }

});

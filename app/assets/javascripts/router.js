var Router = Backbone.Router.extend({

  routes: {
    "": "home",
    "login": "login",
    "register": "register",
    "tickets": "tickets",
    "users": "users"
  },

  execute: function(callback, args, name) {
    if (typeof loginView !== 'undefined') {
      loginView.unbind();
      loginView.undelegateEvents();
    }
    if (typeof registerView !== 'undefined') {
      registerView.unbind();
      registerView.undelegateEvents();
    }
    if (['tickets','users'].includes(name) && !localStorage.auth_token) {
      this.navigate('login', { trigger: true });
      return false;
    }
    else if (['login','register'].includes(name) && localStorage.auth_token) {
      this.navigate("tickets", { trigger: true });
      return false;
    }
    callback.apply(this, args);
  },

  initialize: function() {
  },

  home: function() {
    // tickets
    if (localStorage.auth_token) {
      this.navigate("tickets", {trigger: true});
    }
    else {
      this.navigate("login", {trigger: true});
    }
  },

  login: function() {
    loginView = new LoginView();
    loginView.render();
  },

  register: function() {
    registerView = new RegisterView();
    registerView.render();
  },

  tickets: function() {
    var tickets = new Tickets({ model: Ticket });
    tickets.fetch().success(function(){
      if (typeof ticketsView === 'undefined') {
        ticketsView = new TicketsView({ collection: tickets.models, model: Ticket });
      }
      ticketsView.render();
    });
  },

  users: function() {
    var tickets = new Tickets({ model: Ticket });
    tickets.fetch().success(function(){
      if (typeof ticketsView === 'undefined') {
        ticketsView = new TicketsView({ collection: tickets.models, model: Ticket });
      }
      ticketsView.render();
    });
  },

});

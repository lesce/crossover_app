var LoginView = Backbone.View.extend({

  el: "#main",

  events: {
    "submit .login": "submit",
    "click .register": "goToRegister"
  },

  render: function() {
    var template = _.template($('#login').html());
    this.$el.html(template());
  },

  submit: function(e) {
    e.preventDefault();

    // Get form values
    var loginValues = _.object($(".login").serializeArray().map(function(v) {return [v.name, v.value];}));

    $.ajax({
      method: "POST",
      url: "/users/sign_in",
      dataType: "json",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify({ user: loginValues })
    })
    .fail(function(response) {
      $('.info').html(new ErrorsView({ model: ["Wrong Email or Password."] }).render());
    })
    .success(function(response) {
      localStorage.auth_token = response.auth_token;
      localStorage.email = response.email;
      app.navigate('tickets', {trigger: true});
    });
  },

  goToRegister: function(e) {
    e.preventDefault();
    e.stopPropagation();
    app.navigate('register', {trigger: true});
  }

});

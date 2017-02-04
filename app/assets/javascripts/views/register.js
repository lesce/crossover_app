var RegisterView = Backbone.View.extend({

  el: "#main",

  events: {
    "submit .register": "submit",
    "click .login": "goToLogin"
  },

  render: function() {
    var template = _.template($('#register').html());
    this.$el.html(template());
  },

  submit: function(e) {
    e.preventDefault();

    // Get form values
    var registerValues = _.object($(".register").serializeArray().map(function(v) {return [v.name, v.value];}));

    $.ajax({
      method: "POST",
      url: "/users/",
      dataType: "json",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify({ user: registerValues })
    })
    .fail(function(response) {
      var errors = _.map(response.responseJSON.errors, function(val, key) { return key+" "+val });
      $('.info').html(new ErrorsView({ model: errors  }).render());
    })
    .success(function(response) {
      localStorage.auth_token = response.auth_token;
      localStorage.admin = response.admin;
      localStorage.email = response.email;
      app.navigate('tickets', {trigger: true});
    });
  },

  goToLogin: function(e) {
    e.preventDefault();
    e.stopPropagation();
    app.navigate('login', {trigger: true});
  }

});

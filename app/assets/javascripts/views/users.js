var UsersView = Backbone.View.extend({

  el: "#main",

  initialize: function(){
    _.bindAll(this, 'successFetch');
    this.listenTo(this.collection, "update", this.render);
  },

  events: {
    'click .tickets': 'goToTickets',
    'click .signout': 'signout',
    'click .edit-user': 'edit'
  },

  goToTickets: function(e) {
    e.preventDefault();
    app.navigate('tickets', { trigger: true});
  },

  signout: function(e) {
    e.preventDefault();
    localStorage.removeItem('email');
    localStorage.removeItem('auth_token');
    localStorage.removeItem('admin');
    window.location.reload();
    app.navigate('login', { trigger: true});
  },

  edit: function(e) {
    e.preventDefault();
    var id = $(e.currentTarget).data('id');
    var user = new User({id: id});
    user.fetch({success: this.successFetch});
  },

  successFetch: function(user){
    var userView = new UserView({model: user, collection: this.collection});
    userView.render();
  },

  render: function() {
    var template = Handlebars.compile($('#users').html());
    this.$el.html(template(this.collection.models));
  }

});

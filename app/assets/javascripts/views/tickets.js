var TicketsView = Backbone.View.extend({

  el: "#main",

  initialize: function(){
    _.bindAll(this, 'successFetch', 'successDestroy');
    this.listenTo(this.collection, "add", this.render);
    this.listenTo(this.collection, "update", this.render);
  },

  events: {
    'click .users': 'goToUsers',
    'click .signout': 'signout',
    'click .open-create-ticket': 'create',
    'click .edit-ticket': 'edit',
    'click .remove-ticket': 'remove',
  },

  goToUsers: function(e) {
    e.preventDefault();
    app.navigate('users', { trigger: true});
  },

  signout: function(e) {
    e.preventDefault();
    localStorage.removeItem('email');
    localStorage.removeItem('auth_token');
    localStorage.removeItem('admin');
    window.location.reload();
    app.navigate('login', { trigger: true});
  },

  create: function(e) {
    e.preventDefault();
    var ticketView = new TicketView({model: new Ticket(), collection: this.collection});
    ticketView.render();
  },

  edit: function(e) {
    e.preventDefault();
    var id = $(e.currentTarget).data('id');
    var ticket = new Ticket({id: id});
    ticket.fetch({success: this.successFetch});
  },

  remove: function(e) {
    e.preventDefault();
    var id = $(e.currentTarget).data('id');
    var ticket = new Ticket({id: id});
    ticket.destroy({success: this.successDestroy, error: this.errorDestroy});
  },

  successFetch: function(ticket){
    var ticketView = new TicketView({model: ticket, collection: this.collection});
    ticketView.render();
  },

  errorDestroy: function(){
    alert('You can only remove tickets that have status = open');
  },

  successDestroy: function(ticket){
    this.collection.remove(ticket);
  },

  render: function() {
    var template = Handlebars.compile($('#tickets').html());
    this.$el.html(template(this.collection.models));
  }

});

var TicketView = Backbone.View.extend({

  el: '#create-ticket',

  events: {
    'click .cancel': 'cancel',
    'submit .create-ticket': 'submit',
  },

  initialize: function(){
    this.model.on('saved', this.insertAfterCreate, this);
    this.model.on('updated', this.insertAfterUpdate, this);
  },

  submit: function(e) {
    e.preventDefault();
    var ticketValues = _.object($(".create-ticket").serializeArray().map(function(v) {return [v.name, v.value];}));
    this.model.save(ticketValues);
  },

  insertAfterCreate: function(model, resp) {
    var ticket = model.set(resp.ticket);
    this.collection.push(ticket);
    this.cancel();
  },

  insertAfterUpdate: function(e) {
    this.collection.set(this.collection.models.concat([e]));
    this.cancel();
  },

  cancel: function(e) {
    if (e && e.preventDefault) {
      e.preventDefault();
    }
    this.unbind();
    this.undelegateEvents();
    this.$el.html('');
  },

  render: function() {
    var template = Handlebars.compile($('#ticket').html());
    this.$el.html(template(this.model));
  }

});

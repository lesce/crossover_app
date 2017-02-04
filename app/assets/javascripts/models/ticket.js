var Ticket = Backbone.Model.extend({
  urlRoot: '/api/v1/tickets',

  defaults: {
    title: '',
    content: ''
  },

  parse: function(response) {
    return response.ticket;
  },

  toJSON: function() {
    return { ticket: this.attributes };
  }
});

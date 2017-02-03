var Tickets = Backbone.Collection.extend({
  url: '/api/v1/tickets',

  parse: function(response) {
    return response.tickets;
  }
});

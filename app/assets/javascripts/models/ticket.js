var Ticket = Backbone.Model.extend({
  urlRoot: '/api/v1/tickets',

  parse: function(response) {
    return response.ticket;
  }
});

var ErrorsView = Backbone.View.extend({

  render: function() {
    var template = Handlebars.compile($('#errors').html());
    return template(this.model);
  },

});

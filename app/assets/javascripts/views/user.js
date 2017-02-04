var UserView = Backbone.View.extend({

  el: '#edit-user',

  events: {
    'click .cancel': 'cancel',
    'submit .update-user': 'submit',
  },

  initialize: function(){
    this.model.on('updated', this.insertAfterUpdate, this);
  },

  submit: function(e) {
    e.preventDefault();
    var userValues = _.object($(".update-user").serializeArray().map(function(v) {return [v.name, v.value];}));
    this.model.save(userValues);
  },

  insertAfterUpdate: function(model,resp) {
    var user = model.set(resp.ticket);
    this.collection.set(this.collection.models.concat([user]));
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
    var template = Handlebars.compile($('#user').html());
    this.$el.html(template(this.model));
  }

});

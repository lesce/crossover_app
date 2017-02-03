var oldBackboneSync = Backbone.sync;
Backbone.sync = function(method, collection, options){
  options = options || {};
  if (method == 'read') {
    options.data = "auth_token="+localStorage.auth_token+"&email="+localStorage.email;
  }
  else {
    options.data = JSON.stringify({ auth_token: localStorage.auth_token, email: localStorage.email });
    options.contentType = 'application/json';
  }
  return oldBackboneSync.apply(this, arguments);
}

String.prototype.capitalizeFirstLetter = function() {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

_.each(['title','content','status', 'username', 'id'], function(e){
  var helperName = 'get' + e.capitalizeFirstLetter();
  Handlebars.registerHelper(helperName, function(val) {
    return new Handlebars.SafeString(val.get(e));
  });
});

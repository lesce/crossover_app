var oldBackboneSync = Backbone.sync;
Backbone.sync = function(method, model, options){
  options = options || {};
  if (method == 'read') {
    options.data = "auth_token="+localStorage.auth_token+"&email="+localStorage.email;
  }
  else {
    // set authentication params
    var authData = { auth_token: localStorage.auth_token, email: localStorage.email };
    // merge auth params with params
    options.attrs = _.extend(authData, model.toJSON());
    options.contentType = 'application/json';
    if (method == 'update'){
      // trigger custom event on update success
      options.success = function(resp, status, xhr) {
        model.trigger('updated', model, resp, options);
        if (xhr.success) xhr.success(resp, status, xhr);
      };
    }
    else if (method == 'create'){
      options.success = function(resp, status, xhr) {
      // trigger custom event on create success
        model.trigger('saved', model, resp, options);
        if (xhr.success) {
          xhr.success(resp, status, xhr)
        }
      };
    }
    else if (method == 'delete') {
      // set data for delete requestes ; Backbone.sync doesn't cover the delete req
      options.data = JSON.stringify(options.attrs);
    }
  }
  return oldBackboneSync.apply(this, arguments);
}

String.prototype.capitalizeFirstLetter = function() {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

// Handlebars helpers . Ex: getTitle , getContent ...
_.each(['title','content','status', 'username', 'id'], function(e){
  var helperName = 'get' + e.capitalizeFirstLetter();
  Handlebars.registerHelper(helperName, function(val) {
    return new Handlebars.SafeString(val.get(e));
  });
});

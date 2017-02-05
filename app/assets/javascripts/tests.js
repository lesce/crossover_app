$(function(){
  QUnit.module("Login View", {
    before: function() {
      $("body").append("<div id='main'></div>");
      app = { navigate: function(){}};
      view = new LoginView({ $el: $('#main')});
      view.render();
    },
    after: function() {
      $('#main').remove();
      localStorage.removeItem('auth_token');
      localStorage.removeItem('email');
      localStorage.removeItem('admin');
      view.remove();
    }
  });
  QUnit.test("Login view elements are present", function(assert) {
    assert.equal( view.$("input[name='email']").val(), "" );
    assert.equal( view.$("input[name='password']").val(), "" );
    assert.equal( view.$("button").html(), "Login" );
    assert.equal( view.$(".register").html(), "Register" );
  });
  QUnit.test("Login submit request", function(assert) {
    var email = 'admin@test.eu';
    var password = 'password';
    var done = assert.async();

    view.$("input[name='email']").val(email)
    view.$("input[name='password']").val(password)
    view.submit({preventDefault: function(){}});

    setTimeout(function() {
      assert.ok(localStorage.auth_token);
      assert.ok(localStorage.email);
      assert.ok(localStorage.admin);
      done();
    }, 500);

  });
  QUnit.module("Register View", {
    before: function() {
      $("body").append("<div id='main'></div>");
      app = { navigate: function(){}};
    },
    after: function() {
      $('#main').remove();
    }
  });
  QUnit.test("Register view elements are present", function(assert) {
    var view = new RegisterView({ $el: $('#main')});
    view.render();
    assert.equal( view.$("input[name='email']").val(), "" );
    assert.equal( view.$("input[name='password']").val(), "" );
    assert.equal( view.$("input[name='first_name']").val(), "" );
    assert.equal( view.$("input[name='last_name']").val(), "" );
    assert.equal( view.$("button").html(), "Register" );
    assert.equal( view.$(".login").html(), "Login" );
  });
});

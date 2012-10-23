if (typeof TodoList === 'undefined') {
  var TodoList = {};
}

TodoList.Auth = (function() {
  var obj = {};
  
  obj.start = function() {
    var self = this;

    self.isAuthed(function(isAuthed) {
      if (isAuthed) {
        $('.login').hide();
        TodoList.show();
      } else {
        $('.login').show();
        $(".login").click(function() {
          self.login();
        });
      }
    });
  };

  obj.login = function() {
    $.ajax({
      url: '/login.json',
      success: function(data)  {
        console.log('url', data.url);
        window.open(data.url);
      }
    });
  };

  obj.isAuthed = function(cb) {
    $.ajax({
      url: '/login/is_authed.json',
      success: function(data)  {
        cb(data.authed);
      }
    });
  };

  obj.authed = function() {
    console.log('in authed!!!');
  };

  return obj;
}());


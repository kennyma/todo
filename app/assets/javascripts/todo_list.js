var TodoList = (function() {
  var obj = {};
  
  obj.template = function(tmplUrl, locals, cb) {
    $.ajax({
      url: tmplUrl,
      success: function(rawTemplate) {
        var html = _.template(rawTemplate, locals);
        cb(html);
      }
    });
  };
  
  obj.addTodoItem = function(item, listId) {
    var container = $('.list-container[data-id="' + listId + '"]');
    
    this.template('/templates/todo_list_item.html', { item: item }, function(html) {
      container.find('.items').append(html);
    });
  };
    
  obj.show = function() {
    var self = this;
    
    $.ajax({
      url: '/todo_lists',
      success: function(lists) {
        self.template('/templates/todo_lists.html', { lists: lists }, function(html) {
          $('.main').append(html);
          
          $('.add-todo-list').click(function() {
            $('.todo-list-add-form').show();
          });
          
          $('.todo-list-add-form').submit(function(event) {
            event.preventDefault();
            var target = $(event.target);
            var container = target.parent('.list-container');
            var listId = container.data('id');
            
            var data = $(this).serializeArray();
            data.push({
              name: 'authenticity_token',
              value: $('meta[name="csrf-token"]').attr('content')
            });

            $.ajax({
              url: '/todo_lists/' + listId + "/todos",
              type: 'POST',
              data: data,
              success: function(result) {
                if (result.success) {
                  var item = result.todo_item;
                  self.addTodoItem(item, listId);
                }
              }
            });
          });
        });
        
        _.each(lists, function(list) {
          $.ajax({
            url: '/todo_lists/' + list.id + '/todos.json',
            success: function(todos) {
              _.each(todos, function(todo) {
                self.addTodoItem(todo, list.id);
              });
            }
          });
        });
      }
    });
  };
  
  return obj
})();

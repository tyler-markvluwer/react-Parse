React = require('react') # no ./ prefix
Parse = require('parse')
TodoList = require('./todoList')
TodoListView = require('./todoListView')

# import the Parse api keys. Kept in separate files to keep away from public github
key1 = require('./key1')
key2 = require('./key2')

# Parse imported in index.html
Parse.initialize(key1, key2);

todoList = new TodoList('my_list')

window.todoList = todoList # makes list global and available on console

React.render(
    TodoListView # which component to mount
        todoList: todoList
    document.getElementById('view-mounting-point') # where to mount it
)
EventEmitter = require('events').EventEmitter # used to tell UI when to update
print = require('./utils').print
Parse = require('parse')

# 'TodoList' maps to the name of the 'Class' in parse
ParseTodo = Parse.Object.extend("TodoList")

class TodoList extends EventEmitter
    constructor: (@list_name, @list_items) ->
        if typeof @list_items is "undefined"
            @list_items = [] #contains strings

        @parseQuery = new Parse.Query(ParseTodo)
        
        # Get remote todos
        # Asyncronous!
        @parseQuery.first( # retrieves only first column...because there is only one
            success: (result) =>
                if typeof(result) == 'undefined' # first time ever created
                    @parseTodo = new ParseTodo() # create new ParseTodo
                else
                    @parseTodo = result # use existing cloud ParseTodo

                    parse_todos = result.get('todos') # 'todos' is name of column in Parse
                    print "retrieved todos"
                    @list_items = @list_items.concat parse_todos
                    @emit 'change'
            error: (error) ->
                print "error retrieving todos"
        )

        print "leaving function"

    ###
    This method adds an item to the list
    new_item is a string
    ###
    add_item: (new_item) ->
        @list_items.push new_item
        @parseTodo.addUnique("todos", new_item)
        @parseTodo.save(null,
            success: (parseTodo) =>
                print new_item + " saved!"
            error: (parseTodo, error) =>
                print new_item + " failed!"
                print error
        )

        @emit 'change'

    ###
    this method remos all items that match
    the inputted string
    ###
    remove_item: (kill_item) ->
        @list_items = @list_items.filter (item) -> item isnt kill_item

        @parseTodo.remove("todos", kill_item)
        @parseTodo.save(null,
            success: (parseTodo) =>
                print kill_item + " saved!"
            error: (parseTodo, error) =>
                print kill_item + " failed!"
                print error
        )

        @emit 'change'

    ###
    returns all the items in the list
    ###
    get_items: () ->
        return @list_items

module.exports = TodoList
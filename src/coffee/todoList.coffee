EventEmitter = require('events').EventEmitter # used to tell UI when to update
print = require('./utils').print

class TodoList extends EventEmitter
    constructor: (@list_name, @list_items) ->
        if typeof @list_items is "undefined"
            @list_items = [] # contains strings

    ###
    This method adds an item to the list
    new_item is a string
    ###
    add_item: (new_item) ->
        @list_items.push new_item
        @emit 'change'

    ###
    this method remos all items that match
    the inputted string
    ###
    remove_item: (kill_item) ->
        @list_items = @list_items.filter (item) -> item isnt kill_item
        @emit 'change'

    ###
    returns all the items in the list
    ###
    get_items: () ->
        return @list_items

module.exports = TodoList
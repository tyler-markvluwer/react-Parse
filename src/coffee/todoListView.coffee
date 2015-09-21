React = require('react')

# tag factories
ul = React.createFactory('ul')
li = React.createFactory('li')

todoListView = React.createClass    
    #################################
    #       React Functions
    #################################
    componentDidMount: ->
        @props.todoList.on 'change', @update

    update: ->
        console.log "updating"
        @forceUpdate()

    render: ->
        ul
            className: 'todoList-ul'
            'My Todo List'
            for listItem in @props.todoList.get_items()
                li
                    className: 'todoList-item'
                    listItem
        

module.exports = React.createFactory(todoListView)

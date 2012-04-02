class Alert
  constructor: (@controller, element) ->
    @subscribers = []
    @$ = $(element)
    @_inject()
    @update()

  # Update the alert to reflect the current state.
  update: (notify=true) ->
    @$.toggleClass("amck-filter", @filtered())
    @$link.attr("title", @_title()).html(@_html())
  
    # Notify all subscribers of the change.
    if notify
      for func in @subscribers
        func this

  # Register a function to be called when this alert is updated.
  subscribe: (func) ->
    @subscribers.push func

  # Return true if this alert is currently filtered.
  filtered: ->
    @_repo_event().filtered()

  # Toggle the stored filter state of this alert.
  toggle: ->
    @_repo_event().filtered not @filtered()




  # Private methods:
  
  # Return the name of the repo which spawned this alert.
  _repo_name: ->
    @$.find("div.title > a").last().attr("href")
  
  # Return the event which this alert represents.
  _event_name: ->
    @$.prop("className")
      .replace("alert", "")
      .replace("amck-filter", "")
      .replace(/\s+/g, "")

  # Inject our elements into the DOM.
  _inject: ->
    @$link = $("<div class='amck-filter-this'></div>").appendTo(@$).click =>
      @toggle()
      @update()

  # Return the caption of the show/hide link.
  _html: ->
    if @filtered() then "o" else "x"

  # Return the tooltip of the show/hide link.
  _title: ->
    action = if @filtered() then "Unfilter" else "Filter"
    "#{action} #{@_event_name().toUpperCase()} alerts from #{@_repo_name()}"

  _repo_event: () ->
    @controller.repo_event @_repo_name(), @_event_name()

class FilteredNewsFeed
  constructor: (@controller, container) ->
    @$ = $(container)
    @alerts = []

    @_inject_counter()
    @_rebindEvents()
    @_wrapAlerts @$.find(".alert")
    @maybe_load_more()

  update: ->
    n = 0

    for alert in @alerts
      alert.update(false)
      n++ if alert.filtered()

    @$.find(".amck-gh-filter-counter span").html(n)




  # Private methods:
  
  _rebindEvents: ->
  
    # Hijack clicks to the "More" button (at the bottom of the feed).
    @$.on "click", ".ajax_paginate", (event) =>
  
      # Prevent GitHub's built-in handler from firing.
      event.stopPropagation()
      event.preventDefault()
  
      # Mimic the built-in loading spinner.
      link = $(event.target)
      div = link.parent ".ajax_paginate"
      unless div.hasClass "loading"
        div.addClass "loading"
  
        # Mimic the built-in MORE behavior, except wrapping the new alerts
        # before inserting them into the DOM, and firing another click if there
        # still aren't enough unfiltered alerts.
        $.ajax({
          type: "GET"
          url: link.attr "href"
      
          complete: =>
            div.removeClass "loading"
      
          success: (data) =>
            new_items = $("<div>").append(data).children()
            @_wrapAlerts(new_items.filter(".alert"))
            div.replaceWith new_items
            @maybe_load_more()
        })
  
  _wrapAlerts: (items) ->
    items.each (i, element) =>
      a = new Alert(@controller, element)
      a.subscribe @update.bind(this)
      @alerts.push a
  
    @update()
  
  _inject_counter: ->
    @$.prepend("""
      <div class="amck-gh-filter-counter">
        Filtered <span>0</span> alerts
        <a href="">Show all</a>
      </div>
    """)
  
    @$.on "click", ".amck-gh-filter-counter a", (event) =>
      @$.find(".alert:hidden").show()
      event.preventDefault()

  maybe_load_more: ->
    if @$.find(".alert:visible").length < 20
      @$.find(".ajax_paginate a").click()

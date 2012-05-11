class EventsButton
  constructor: (@repo) ->
    el = @buildElements()
    @bindEvents(el)
    @inject(el)
    @positionContextPane(el)

  # Return the HTML of this button.
  # Adapted from the GitHub branch switcher.
  buildElements: ->
    $("""
    <li class="context-menu-container js-menu-container amck-filters-button-container">
      <a href="#" class="minibutton switcher js-menu-target"><span>
        Alerts
      </span></a>
  
      <div class="context-pane js-menu-content">
        <a href="javascript:;" class="close js-menu-close">
          <span class="mini-icon remove-close"></span>
        </a>
        <div class="context-title">Configure Alerts</div>
        <div class="context-body">
          <table class="notifications">
          </table>
          <div class="help">
            Select the alerts you wish
            to see in your news feed.
          </div>
        </div>
      </div>
    </li>
    """)
      .find("table.notifications")
        .append(@_rows() ...)
      .end()

  positionContextPane: (element) ->
    left = element.find("a.js-menu-target").position().left
    element.find("div.js-menu-content").css("left", left)

  bindEvents: (element) ->
    element.on "change", "table.notifications input", @_checkbox_change

  inject: (element) ->
    $("li.watch-button-container").after(element)


  # Private functions

  _rows: ->
    for repoEvent in @repo.events()
      $("""
      <tr>
        <td><label for="#{repoEvent.getId()}">
          #{repoEvent.getCaption()}
        </td>
        <td class="checkbox"></td>
      </tr>
      """)
        .find("td.checkbox")
          .append(@_checkbox(repoEvent))
        .end()

  _checkbox: (repoEvent) ->
    $("<input type='checkbox' id='#{repoEvent.getId()}'>")
      .attr("checked", not repoEvent.filtered())
      .data("repoEvent", repoEvent)

  _checkbox_change: (event) ->
    el = $(event.target)
    is_filtered = not el.is(":checked")
    el.data("repoEvent").filtered(is_filtered)

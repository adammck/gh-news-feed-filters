DEBUG = true

log = (args...) ->
  console.log(args...) if DEBUG

on_repo_page = ->
  $(".repohead").length > 0


init = ->
  if on_repo_page()
    new RepoPage




# Models

class Event
  constructor: (@name, @caption) ->

class FilterSet
  constructor: (@repo_name) ->

  is_filtered: (event_name) ->
    event_name in @get_item()

  update: (event_name, is_filtered) ->
    s = (e for e in @get_item() when e isnt event_name)
    s.push(event_name) if is_filtered
    @set_item(s)

  key: ->
    "amck-gh-filter" + @repo_name

  pack: (val) ->
    val.join " "

  unpack: (val) ->
    if val? and val isnt ""
      val.split(/\s+/)
    else []

  get_item: ->
    @unpack(localStorage.getItem(@key()))

  set_item: (val) ->
    localStorage.setItem(@key(), @pack(val))




# Views

class RepoPage
  constructor: ->
    filter_set = new FilterSet(@repo_name())
    new FilterButton(filter_set).inject()

  repo_name: ->
    $(".js-current-repository").attr("href")




# Controls

class FilterButton
  constructor: (@filter_set) ->

  inject: ->
    element = $(@html())
    @bind_events(element)
    $("head").append "<style>#{@css()}</style>"
    $("li.watch-button-container").after(element)

  click: (element) ->
    @filter_set.update(element.value, element.checked)

  bind_events: (container) ->
    $("table.notifications", container).delegate "input", "change", (event) =>
      @click(event.target)

  html: ->
    """
    <li class="amck-gh-filter context-menu-container js-menu-container">
      <a href="#" class="minibutton switcher js-menu-target"><span>
        Filters
      </span></a>

      <div class="context-pane js-menu-content">
        <a href="javascript:;" class="close js-menu-close"></a>
        <div class="context-title">Filter Events</div>
        <div class="context-body">
          <table class="notifications">
            #{@rows()}
          </table>
          <div class="help">
            Select event types to filter
            them from your news feed
          </div>
        </div>
      </div>
    </li>
    """

  rows: ->
    (@row(e) for e in events).join("\n")

  row: (event) ->
    """
    <tr>
      <td><label for="amck-#{event.name}">#{event.caption}</td>
      <td class="checkbox">#{@checkbox(event)}</td>
    </tr>
    """

  checkbox: (event) ->
    checked = if @filter_set.is_filtered(event.name) then "checked" else ""
    "<input type='checkbox' id='amck-#{event.name}' value='#{event.name}' #{checked}>"

  css: ->
    """
    /* Patch the page header to allow the repo actions bar to contain menus. */
    .pagehead .title-actions-bar           { overflow: visible; }
    .pagehead.repohead ul.pagehead-actions { top: -2px; }
    .pagehead h1                           { float: left; }


    /* The drop-down notifications menu. */

    .amck-gh-filter .minibutton {
      padding-left: 0;
    }

    .amck-gh-filter .context-pane {
      margin: 5px 0 0 95px;
      width: 180px;
    }

    .amck-gh-filter table.notifications {
      margin-bottom: 0;
    }

    .amck-gh-filter table.notifications td {
      padding: 5px 0;
      font-weight: normal;
    }

    .amck-gh-filter table.notifications tr:first-child td {
      padding-top: 0;
    }
    
    .amck-gh-filter table.notifications tr:last-child td {
      border-bottom-color: #eee;
    }

    .amck-gh-filter div.help {
      padding: 5px 10px 0 10px;
      text-align: center;
      font-weight: normal;
      font-size: 11px;
      color: #aaa;
    }
    """




events = [
  new Event "push",   "Pushes"
  new Event "branch", "Branches"
  new Event "tag",    "Tags"
  new Event "issue",  "New Issues"
  new Event "pull",   "Pull Requests"
  new Event "wiki",   "Wiki Updates"
]

init()


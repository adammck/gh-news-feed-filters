PREFIX = "amck"


class Repo
  constructor: (@name) ->

  key: ->
    PREFIX + @name

  pack: (val) ->
    val.join " "

  unpack: (val) ->
    if val? and val isnt "" then val.split(/\s+/) else []

  get: ->
    @unpack(localStorage.getItem(@key()))

  set: (val) ->
    localStorage.setItem(@key(), @pack(val))

  get_notify: (event) ->
    event not in @get()

  set_notify: (event, value) ->
    s = (e for e in @get() when e isnt event)
    s.push(event) unless value
    @set(s)


class Notifications
  constructor: (@repo, @doc) ->

  checkbox: (event) ->
    checked = if @repo.get_notify(event) then "checked" else ""
    "<input type='checkbox' id='#{PREFIX}-chk-#{event}' value='#{event}' #{checked}>"

  attach_events: (container) ->
    container.delegate "input", "change", (event) =>
      t = $(event.target)
      @repo.set_notify(t.val(), t.is(":checked"))

  injectCSS: ->
    $("head", @doc).append "<style>#{@CSS()}</style>"

  $container: ->
    $("li.watch-button-container", @doc)

  $button: ->
    $("a.watch-button", @$container())

  hijack_button: ->
    @$button().
      removeAttr("data-method").
      removeAttr("data-remote").
      attr("href", "#")

    @$container().
      addClass("context-menu-container js-menu-container").
      removeClass("js-toggler-container on")

    @$button().
      removeClass("js-toggler-target").
      addClass("switcher js-menu-target")

  inject: () ->
    @injectCSS()
    x = $(@HTML())
    @attach_events(x)
    @hijack_button()
    @$container().append(x)

  CSS: ->
    """
    .pagehead .title-actions-bar {
        overflow: visible;
    }

    .pagehead h1 {
        float: left;
    }

    .pagehead.repohead ul.pagehead-actions {
        top: -2px;
    }

    .#{PREFIX}-notifications {
        margin: 5px 0 0 5px;
        width: 229px;
    }

    .#{PREFIX}-notifications table.notifications {
        margin-bottom: 0;
    }

    .#{PREFIX}-notifications table.notifications td {
        padding: 5px 0;
        font-weight: normal;
    }

    .#{PREFIX}-notifications table.notifications tr:first-child td {
        padding-top: 0;
    }

    .#{PREFIX}-notifications table.notifications tr:last-child td {
        border-bottom: none;
        padding-bottom: 0;
    }
    """

  HTML: ->
    """
    <div class="#{PREFIX}-notifications context-pane js-menu-content">
      <a href="javascript:;" class="close js-menu-close"></a>
      <div class="context-title">Notifications</div>
      <div class="context-body">
        <table class="notifications">
          <tr>
            <td><label for="#{PREFIX}-chk-push">Pushes</td>
            <td class="checkbox">#{this.checkbox("push")}</td>
          </tr>
          <tr>
            <td><label for="#{PREFIX}-chk-branch">Branches</td>
            <td class="checkbox">#{this.checkbox("branch")}</td>
          </tr>
          <tr>
            <td><label for="#{PREFIX}-chk-tag">Tags</td>
            <td class="checkbox">#{this.checkbox("tag")}</td>
          </tr>
          <tr>
            <td><label for="#{PREFIX}-chk-issue">Issues</td>
            <td class="checkbox">#{this.checkbox("issue")}</td>
          </tr>
          <tr>
            <td><label for="#{PREFIX}-chk-pull">Pull Requests</td>
            <td class="checkbox">#{this.checkbox("pull")}</td>
          </tr>
          <tr>
            <td><label for="#{PREFIX}-chk-wiki">Wiki Updates</td>
            <td class="checkbox">#{this.checkbox("wiki")}</td>
          </tr>
        </table>
      </div>
    </div>
    """


if $(".repohead").length
  repo = new Repo $(".js-current-repository").attr("href")
  notifications = new Notifications repo, document
  notifications.inject();

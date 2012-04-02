class RepoPage
  constructor: (@$) ->
    repo = new Repo @repo_name()
    new EventsButton repo

  repo_name: ->
    @$(".js-current-repository").attr("href")

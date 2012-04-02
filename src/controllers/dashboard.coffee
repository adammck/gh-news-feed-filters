class DashboardPage
  constructor: (@$) ->
    
    # Caches: These aren't really necessary for things to work, but wrapping
    # a long news feed otherwise initializes a ton of very brief objects.
    @_repos = {}
    @_repo_events = {}
    @_events = {}
    for evt in Event.all()
      @_events[evt.name] = evt

    new FilteredNewsFeed this, @$("#dashboard > .news")

  # Get or set whether `event_name` should be filtered in `repo_name`.
  filtered: (repo_name, event_name) ->
    @_repo_event(repo_name, event_name).filtered()
    
  repo_event: (repo_name, name) ->
    new BoundEvent @_repo(repo_name), @_event(name)




  # Private methods:

  _repo: (name) ->
    @_repos[name] or (@_repos[name] = new Repo name)

  _event: (name) ->
    @_events[name] or (new Event name)
class Repo
  constructor: (@name) ->

  # Return the name of this repo, as it would appear in the Title Action Bar.
  # This usually looks like: "username/repo-name".
  getName: -> @name

  # Return the BoundEvent objects for this repo. This includes ALL events,
  # whether or not they are already filtered.
  events: ->
    new BoundEvent(this, evt) for evt in Event.all()

  # Get or set whether a BoundEvent should be filtered for this repo.
  eventFiltered: (repo_event, is_filtered=null) ->
    name_set = @_getFilteredEventNames()
    name = repo_event.getName()

    if is_filtered is null # Get
      name in name_set

    else # Set
      name_set = (n for n in name_set when n isnt name)
      name_set.push(name) if is_filtered
      @_setFilteredEventNames(name_set)




  # Private methods:

  _getFilteredEventNames: ->
    @_unpack(localStorage.getItem(@_getKey()))

  _setFilteredEventNames: (val) ->
    packed = @_pack(val)

    if packed.length
      localStorage.setItem(@_getKey(), packed)

    else
      localStorage.removeItem(@_getKey())

  _getKey: ->
    "amck-gh-filter" + @name

  _pack: (val) ->
    val.join(" ")

  _unpack: (val) ->
    if val? and val isnt ""
      val.split(/\s+/)
  
    else []

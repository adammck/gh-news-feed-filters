class BoundEvent
  constructor: (@repo, @event) ->
  
  # Get or set whether this should be filtered.
  filtered: (is_filtered) ->
    @repo.eventFiltered(this, is_filtered)

  # This is pretty weird.
  getName:    -> @event.name
  getCaption: -> @event.caption
  getId:      -> "amck-filters-" + @event.name

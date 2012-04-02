# This class represents an Event Type. It probably would not be useful to
# instantiate one outside of the `Event.all` function.

class Event
  constructor: (@name, @caption) ->

  @all: -> [
    new Event "push",            "Pushed"
    new Event "fork",            "Forked"
    new Event "create",          "Branch/Tag Created"
    new Event "delete",          "Branch/Tag Deleted "
    new Event "commit_comment",  "Commit Commented"
    new Event "issues_opened",   "Issue Opened"
    new Event "issues_reopened", "Issue Repened"
    new Event "issues_comment",  "Issue Commented"
    new Event "issues_closed",   "Issue Closed"
    new Event "watch_started",   "Watched"
    new Event "member_add",      "Member Added"
    new Event "gollum",          "Wiki Updated"
    new Event "download",        "File Uploaded"
  ]

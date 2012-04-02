do ->
  if $(".repohead").length > 0
    new RepoPage($)

  else if $("#dashboard > .news").length > 0
    new DashboardPage($)

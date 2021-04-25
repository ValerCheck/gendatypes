`%??%` <- function(lhs, rhs)
{
  UseMethod("%??%")
}

defaultIf <- function(.predicate, .value, .default)
{
  if (.predicate(.value)) .default
  else .value
}

`%??%.default` <- function(lhs, rhs) {
  defaultIf(function(x) is.na(x) || is.null(x) || is.nan(x), lhs, rhs)
}

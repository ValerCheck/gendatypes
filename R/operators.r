#' Extract parts of the typed_list object and convert them to typed_list for further extraction
#'
#' @param lhs Input object
#' @param rhs Part of the object
#'
#' @return list of parts of input colleciton of objects
#' @export
`%$%` <- function(lhs, rhs)
{
  if (!is_typed_list(lhs))
    stop(paste("`$$` operator is applicable only for typed_list objects, but provided object was of type", typeof(lhs), "and class", class(lhs), sep = " "))
  parameter <- as.character(substitute(rhs))
  lapply(lhs, `[[`, parameter) %>% as.typed_list()
}

#' Double-question S3 generic operator
#'
#' @param lhs left argument
#' @param rhs right argument
#'
#' @export
`%??%` <- function(lhs, rhs)
{
  UseMethod("%??%")
}

#' @export
`%??%.default` <- function(lhs, rhs) {
  defaultIf(isValueMissing, lhs, rhs)
}

#' Default-if function
#'
#' @param .predicate Function to use for evaluation for returning default
#' @param .value value to evaluate with predicate
#' @param .default default value to return if .value has not passed predicate check
#'
#' @export
defaultIf <- function(.predicate, .value, .default)
{
  if (.predicate(.value)) .default
  else .value
}

isValueMissing <- function(value)
{
  isEmpty <- rlang::is_empty(value)
  isAtomic <- rlang::is_atomic(value)

  if (isAtomic && isEmpty)
  {
    return (TRUE)
  }

  if (is(value, "numeric"))
    return (is.nan(value))

  if (is(value, "logical"))
    return (is.na(value))

  return (is.null(value))
}

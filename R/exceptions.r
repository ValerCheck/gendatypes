#' Wrapper for stop function
#'
#' @param arg argument which must be a part of exception
#' @param message additional message to exception
#'
#' @export
throw_exception <- function(arg, message = NULL)
{
  if (!missing(message)) message(message)
  stop("Argument `", substitute(arg), "` is incorrect!")
}

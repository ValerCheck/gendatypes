throw_exception <- function(arg, message = NULL)
{
  if (!missing(message)) message(message)
  stop("Argument `", substitute(arg), "` is incorrect!")
}

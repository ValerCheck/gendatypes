with_class <- function(obj, className) {
  invisible(structure(obj, class = c(dplyr::setdiff(className, class(obj)), class(obj))))
}

validate_classes <- function(object, ..., classes = character())
{
  if (missing(classes)) classes <- list(...)

  if (is_empty(classes)) stop("At least one class name must be provided")

  if (any(sapply(classes, function(class) is(object, class))))
    object
  else
    stop(paste("\nProvided object must have one of classes:",
               paste(classes, collapse = ", "),
               "\nInstead provided object is of class",
               paste(class(object), collapse=", ")))
}

c_extended <- function(..., as.names = TRUE, as.list = FALSE)
{
  require(magrittr)
  result <- c(...)

  if (as.names == TRUE) {
    result <- result %>% purrr::set_names()
  }

  if (as.list == TRUE) {
    result <- result %>% as.list()
  }

  result
}

usethis::use_package("dplyr")
usethis::use_package("purrr")
usethis::use_package("magrittr")
usethis::use_package("methods")
usethis::use_package("rlang")

#' Extend class of object
#'
#' @param obj object under test
#' @param className class to append to list of classes
#'
#' @export
with_class <- function(obj, className) {
  invisible(structure(obj, class = c(dplyr::setdiff(className, class(obj)), class(obj))))
}

#' Validate that object contains at least one class from provided list of classes
#'
#' @param object object under test
#' @param ... dots argument for classes if empty
#' @param classes vector of classes
#'
#' @return input object
#' @export
validate_classes <- function(object, ..., classes = character())
{
  if (missing(classes)) classes <- list(...)

  if (rlang::is_empty(classes)) stop("At least one class name must be provided")

  if (any(sapply(classes, function(class) methods::is(object, class))))
    object
  else
    stop(paste("\nProvided object must have one of classes:",
               paste(classes, collapse = ", "),
               "\nInstead provided object is of class",
               paste(class(object), collapse=", ")))
}

#' Extended vector creation function
#'
#' @param ... items to vectorize
#' @param as.names make names from items in a vector
#' @param as.list return resulting object as a list
#' @importFrom magrittr %>%
#'
#' @export
c_extended <- function(..., as.names = TRUE, as.list = FALSE)
{
  result <- c(...)

  if (as.names == TRUE) {
    result <- result %>% purrr::set_names()
  }

  if (as.list == TRUE) {
    result <- result %>% as.list()
  }

  result
}

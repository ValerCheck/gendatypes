class_names.typed_list <- "typed_list"

#' Typed list
#'
#' Typed list ensures all items in the list are of the same type.
#' However, ducktyping takes place, which is if the element has target class
#' it doesn't mean that it has the same structure as other items in the list.
#'
#' @param x input object
#' @param type_class generic class name of elements in the list
#' @importFrom methods is
#' @importFrom rlang is_named
#' @importFrom magrittr %>%
#' @return typed list with appropriate type assigned
#' @export
as.typed_list <- function(x, type_class) {

  stopifnot(!is.atomic(x))

  if (missing(type_class)) type_class <- class(x[[1]])[1]

  if (any(sapply(x, is.atomic)))
    stop("Only recursive items (i.e. list) are allowed for creating typed collection!")

  if (any(sapply(x, function(x) !is_named(x))))
    stop("Only named items must be provided in the list")

  if (!all(sapply(x, function(x) is(x, type_class))))
    stop("All items in collection must be of type: ", type_class)

  structure(with_class(x, class_names.typed_list), type = type_class)
}

#' Typed list class check
#'
#' Check whether object is of class 'typed_class'
#'
#' @param x object under test
#'
#' @return TRUE or FALSE
#' @export
is_typed_list <- function(x) {
  methods::is(x, class_names.typed_list)
}

#' Get generic type of items in the 'typed_list'
#'
#' @param x object under test
#'
#' @return generic type of items
#' @export
typed_list.typeof <- function(x) {
  attr(validate_typed_list_class(x), "type")
}

#' Check typed_list generic type of items
#'
#' @param x object under test
#' @param type_class class name to check for generic type
#'
#' @return TRUE or FALSE
#' @export
typed_list.is <- function(x, type_class) {
  attr(validate_typed_list_class(x), "type") == type_class
}

#' Validate that object has typed list class
#'
#' @param x object under test
#'
#' @export
validate_typed_list_class <- function(x) {
  stopifnot(is_typed_list(x))
  invisible(x)
}

# S3 Methods --------------------------------------------------------------

#' S3 method for '$' function for typed_list
#'
#' @param x object under test
#' @param name property name
#'
#' @export
`$.typed_list` <- function(x, name) {
  name <- as.character(substitute(name))
  sapply(x, `[[`, name)
}

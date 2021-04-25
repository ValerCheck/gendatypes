class_names.typed_list <- "typed_list"

`$.typed_list` <- function(x, name) {
  name <- as.character(substitute(name))
  sapply(x, `[[`, name)
}

as.typed_list <- function(x, type_class) {
  stopifnot(!is.atomic(x))

  if (missing(type_class)) type_class <- class(x[[1]])[1]

  if (any(sapply(x, is.atomic)))
    stop("Only recursive items (i.e. list) are allowed for creating typed collection!")

  if (any(sapply(x, function(x) !rlang::is_named(x))))
    stop("Only named items must be provided in the list")

  if (!all(sapply(x, function(x) is(x, type_class))))
    stop("All items in collection must be of type: ", type_class)

  structure(x %>% with_class(class_names.typed_list), type = type_class)
}

is_typed_list <- function(x) {
  is(x, class_names.typed_list)
}

typed_list.of_type <- function(x, type_class) {
  stopifnot(is_typed_list(x))
  attr(x, "type") == type_class
}

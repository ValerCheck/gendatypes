library(gendatypes)
library(testthat)



# with_class --------------------------------------------------------------

test_that("with_class adds class to object", {
  object <- list()
  object <- with_class(object, "test_class")
  expect_s3_class(object, "test_class")
})

test_that("with_class don't add class if object already contains it",
{
  object <- structure(list(), class = "custom_class")
  object <- with_class(object, c("custom_class", "custom_class_two"))
  object_classes <- class(object)
  expect_length(object_classes, 2)
  expect_s3_class(object, "custom_class")
  expect_s3_class(object, "custom_class_two")
})

# validate_classes --------------------------------------------------------

test_that("validate_classes stops if no classes were provided as argument", {
  expect_error(validate_classes(list()))
})

test_that("validate_classes stops if no class was found", {
  object <- structure(list(), class = "object_under_test")
  expect_error(validate_classes(object, classes = "not_relevant_class"))
})

test_that("validate_classes passes successfully if class was found", {
  object <- structure(list(), class = "object_under_test")
  expect_visible(validate_classes(object, classes = "object_under_test"))
})

test_that("validate_classes uses dots arguments if classes parameter is not defined", {
  object <- structure(list(), class = "object_under_test")
  expect_visible(validate_classes(object, "object_under_test"))
})

# c_extended --------------------------------------------------------------

test_that("c_extended creates vector with the same names as values", {
  result <- names(c_extended(1,2,3))
  expect_equal(result, c("1", "2", "3"))
})

test_that("c_extended creates vector the same way as simple c function", {
  expected <- c(1,2,3)
  actual <- c_extended(expected, as.names = F)
  expect_equal(actual, expected)
})

test_that("c_extended creates a list with names of values", {
  expected <- list("1" = 1, "2" = 2, "3" = 3)
  actual <- c_extended(1,2,3, as.list = T)
  expect_equal(actual, expected)
})

library(gendatypes)
library(testthat)

test_that("throw_exception stops execution", {
  result <- list()
  expect_error(throw_exception(result), regexp = "Argument `result` is incorrect!")
})

test_that("throw_exception displays custom message", {
  result <- list()
  expect_error(expect_message(throw_exception(result, message = "Custom error!")))
})

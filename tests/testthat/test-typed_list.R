library(testthat)

test_that("coersion to typed_list throws error for atomic vectors", {
  expect_error(as.typed_list(1:10))
  expect_error(as.typed_list(c("one", "two", "three")))
  expect_error(as.typed_list(c(TRUE, FALSE)))
  expect_error(as.typed_list(numeric()))
})

test_that("coersion to typed_list is possible only from list with recursive items", {
  expect_error(as.typed_list(list(1,2,3)), "Only recursive items \\(i.e. list\\) are allowed")
  expect_error(as.typed_list(list(T,F,3)), "Only recursive items \\(i.e. list\\) are allowed")
  expect_error(as.typed_list(list(1,"a",F)), "Only recursive items \\(i.e. list\\) are allowed")
})

# test_that("typed_list has type of the first element if type_class argument is missing", {
#   expect_is(as.typed_list(list(1,2,3)), "typed_list")
# })

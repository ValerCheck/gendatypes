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

test_that("only named recursive object are allowed for coersion to typed_list", {
  expect_error(as.typed_list(list(list(1,2,3))), "Only named items must be provided in the list")
  expect_error(as.typed_list(list(list(a = 13), list(4,5))), "Only named items must be provided in the list")
  expect_error(as.typed_list(list(list(a = 13), list(4,5))), "Only named items must be provided in the list")
})

test_that("when pass list with one named list item expect successful coersion to typed_list with type 'list'", {
  tlist <- as.typed_list(list(list(a = 1, b = 2, c = 3)))
  expect_s3_class(tlist, "typed_list")
  expect_true(is_typed_list(tlist))
  expect_true(typed_list.is(tlist, "list"))
})

test_that("when pass list with multiple items with different classes expect coersion to typed_list fails", {
  expect_error(as.typed_list(list(list(a = 1, b = 2), structure(list(a = 1), class = "non-standard class"))))
})

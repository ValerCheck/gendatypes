library(testthat)
library(gendatypes)

test_that("Double question operator returns left operand if it is defined", {
  expect_equal(1 %??% 2, 1)
  expect_equal(list() %??% 1, list())
})

test_that("Double question operator returns right operand if left is undefined",
{
  expect_equal(NA %??% 1, 1)
  expect_equal(NULL %??% 2, 2)
  expect_equal(NaN %??% 3, 3)
  expect_equal(logical(0) %??% list(), list())
})

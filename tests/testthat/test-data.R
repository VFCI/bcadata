test_that("original bcadata exists", {
  expect_equal(class(original_bcadata), c("tbl_df", "tbl", "data.frame"))
})

test_that("original bcadata is the right size", {
  expect_equal(dim(original_bcadata), c(252, 11))
})

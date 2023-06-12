test_that("multiplication works", {
  p <- compare_bcadata(original_bcadata)
  expect_equal(class(p), c("gg", "ggplot"))
})

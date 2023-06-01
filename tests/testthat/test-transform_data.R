test_that("Transformed data is nonempty", {
  testkey <- "7fdf94c38c6355269067736a82bf7874"
  df <- transform_data(pull_fred_data(testkey), pull_tfp_data())
  expect_equal(class(df), c("tbl_df", "tbl", "data.frame"))
  expect_true(dim(df)[1] > 0 & dim(df)[2] > 0)
})

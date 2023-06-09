if (requireNamespace("httr", quietly = TRUE)) {
  test_that("TFP link is valid", {
    http_status_ok <- 200
    tfp_link <-
      "http://www.frbsf.org/economic-research/files/quarterly_tfp.xlsx"
    expect_equal(httr::HEAD(tfp_link)$status, http_status_ok)
  })
}

if (requireNamespace("httr", quietly = TRUE)) {
  test_that("Archive TFP link is valid", {
    http_status_ok <- 200
    tfp_link <-
      paste0(
      "https://drive.google.com/uc?export=download",
      "&id=1Amw-RcqwekawJbNvSFLzOE9w3DvjF9tt"
    )
    expect_equal(httr::HEAD(tfp_link)$status, http_status_ok)
  })
}

test_that("TFP data is nonempty", {
  df <- pull_tfp_data()
  expect_equal(class(df), c("tbl_df", "tbl", "data.frame"))
  expect_true(dim(df)[1] > 0 & dim(df)[2] > 0)
})

test_that("Archive TFP data is nonempty", {
  df <- pull_tfp_data(replicate = TRUE)
  expect_equal(class(df), c("tbl_df", "tbl", "data.frame"))
  expect_true(dim(df)[1] > 0 & dim(df)[2] > 0)
})

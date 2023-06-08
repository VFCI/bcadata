test_that("Validate Updated BCA data", {
  testkey <- "7fdf94c38c6355269067736a82bf7874"
  df <- pull_bcadata(testkey)

  ## Make sure it's nonempty tibble
  expect_equal(class(df), c("tbl_df", "tbl", "data.frame"))
  expect_true(dim(df)[1] > 0 & dim(df)[2] > 0)

  ## Validate the series
  if (requireNamespace("testdat", quietly = TRUE)) {

    testdat::expect_unique("date", data = df)
    testdat::expect_range("date", as.Date("1950-01-01"), Sys.Date(), data = df)

    testdat::expect_range("unemployment", 0, 50, data = df)
    testdat::expect_range("inflation", -10, 50, data = df)
    testdat::expect_range("interest", -5, 20, data = df)
    testdat::expect_range("hours_worked", 1500, 2000, data = df)
    testdat::expect_range("labor_share", 300, 600, data = df)

    testdat::expect_range("output", 0, +Inf, data = df)
    testdat::expect_range("consumption", 0, +Inf, data = df)
    testdat::expect_range("investment", 0, +Inf, data = df)
    testdat::expect_range("productivity", 0, +Inf, data = df)
    testdat::expect_range("TFP", 0, +Inf, data = df)

    ## Check growth rates of non-rate variables
    df_rate <- df |>
      dplyr::mutate(
        output_rate = output / dplyr::lag(output, 4) - 1,
        consumption_rate = consumption / dplyr::lag(consumption, 4) - 1,
        investment_rate = investment / dplyr::lag(investment, 4) - 1,
        productivity_rate = productivity / dplyr::lag(productivity, 4) - 1,
        TFP_diff = TFP - dplyr::lag(TFP, 4)
      )

    testdat::expect_range("output_rate", -0.1, 0.1, data = df_rate)
    testdat::expect_range("consumption_rate", -0.1, 0.1, data = df_rate)
    testdat::expect_range("investment_rate", -0.1, 0.1, data = df_rate)
    testdat::expect_range("productivity_rate", -0.1, 0.1, data = df_rate)
    testdat::expect_range("TFP_diff", -20, 20, data = df_rate)

  }

})


test_that("Validate Replicated BCA data", {
  testkey <- "7fdf94c38c6355269067736a82bf7874"
  df <- pull_bcadata(testkey, replicate = TRUE) |>
    dplyr::filter(lubridate::year(date) <= 2017)

  df[, "TFP"] <- df[, "TFP"] - 20.26

  expect_equal(df, original_bcadata, tolerance = 0.1)
})

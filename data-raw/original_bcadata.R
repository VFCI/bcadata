## code to prepare `original_bcadata` dataset goes here
require(R.matlab)
require(dplyr)
require(readr)
require(zoo)

m <- readMat("./data-raw/original_bcadata.mat")

varnames <- c(
    "date", "output", "investment", "consumption",
    "hours_worked", "unemployment", "labor_share",
    "interest", "inflation", "productivity", "TFP"
    )

df <- as_tibble(m$X)

names(df) <- varnames

original_bcadata <-
    df |>
    mutate(date = as.Date.yearqtr(as.yearqtr(date)))

write_csv(original_bcadata, "data-raw/original_bcadata.csv")
usethis::use_data(original_bcadata, overwrite = TRUE)

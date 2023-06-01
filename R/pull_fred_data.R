#' Pull data from FRED
#'
#' @param fred_api_key API key from FRED
#'
#' @return A tibble/data.frame
#'
pull_fred_data <- function(fred_api_key) {
  fredr::fredr_set_key(fred_api_key)

  ## Fred series codes that are pulled
  series <- c(
    gdpcap = "A939RX0Q048SBEA",
    gdp = "GDP",
    rgdp = "GDPC1",
    gdpdef = "GDPDEF",
    sh_nondur = "DNDGRE1Q156NBEA",
    sh_ser = "DSERRE1Q156NBEA",
    sh_dur = "DDURRE1Q156NBEA",
    sh_inv = "A006RE1Q156NBEA",
    oph = "OPHNFB",
    labor_sh = "PRS85006173",
    hw = "PRS85006023",
    pop = "CNP16OV",
    emp_pop = "CE16OV",
    ur = "UNRATE",
    ff = "FEDFUNDS"
  )

  my_fredr <- function(series, frequency){
    agg <- ifelse(series == "CNP16OV", "eop", "avg")
    fredr::fredr(series, frequency = frequency, aggregation_method = agg)
  }

  data <- Reduce(rbind, lapply(
    series, my_fredr,
    frequency = "q"
  ))

  data <- data[, c("date", "series_id", "value")]

  data <- data[!is.na(data$value), ]

  data <- data |>
    tidyr::pivot_wider(names_from = "series_id", values_from = "value")

  names(data) <- c("date", names(series))

  data <- dplyr::as_tibble(data) |>
    dplyr::arrange(date)

  return(data)
}

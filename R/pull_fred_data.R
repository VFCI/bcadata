#' Pull data from FRED
#'
#' @param fred_api_key API key from FRED
#'
#' @return A tibble/data.frame.
#' @export
#'
#' @examples
#' \dontrun{
#' data <- pull_fred_data("XXXXXXXXXXX")
#' }
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

  data <- Reduce(rbind, lapply(
    series, fredr::fredr,
    frequency = "q", aggregation_method = "eop"
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

#' Merge FRED, TFP data and construct correct series
#'
#'
#' @param fred_data Data.frame from pull_fred_data
#' @param tfp_data Data.frame from pull_tfp_data
#'
#' @return A tibble/data.frame
#' @export
#'
#' @examples
#' \dontrun{
#' data <- transform_data(fred_data, tfp_data)
#' }
transform_data <- function(fred_data, tfp_data) {
  df <- dplyr::full_join(fred_data, tfp_data, by = "date")

  df <- df |> dplyr::filter(lubridate::year(date) >= 1948)

  ## Reindex labor share to 100 = 2009
  lsh2009 <- df |>
    dplyr::filter(lubridate::year(date) == 2009) |>
    dplyr::pull(labor_sh) |>
    mean()

  ## Back out pop from gdp
  df <- df |>
    dplyr::mutate(
      pop2 = rgdp / gdpcap,
      output = 100 * log(gdpcap),
      consumption = 100 * log((sh_nondur + sh_ser) * gdpcap),
      investment = 100 * log((sh_dur + sh_inv) * gdpcap),
      hours_worked = 100 * log(hw * emp_pop / pop2),
      inflation = 100 * log(gdpdef / dplyr::lag(gdpdef, 1)),
      interest = ff / 4,
      productivity = 100 * log(oph),
      labor_sh = labor_sh / lsh2009,
      labor_share = 100 * log(labor_sh),
      TFP = 100 * cumsum(dtfp_util / 400),
      unemployment = ur
    )

  ## Start the TFP series counting from 0
  df <- df |>
    dplyr::mutate(TFP - df[1, "TFP"])

  df <- df |>
    dplyr::select(c(
      "date", "output", "investment", "consumption",
      "hours_worked", "unemployment", "labor_share",
      "interest", "inflation", "productivity", "TFP"
    ))

  df <- df |>
    dplyr::filter(lubridate::year(date) >= 1955) |>
    tidyr::drop_na()

  return(df)
}
utils::globalVariables(c(
  "labor_sh", "rgdp", "gdpcap", "sh_nondur", "sh_ser", "sh_dur", "sh_inv",
  "hw", "emp_pop", "pop2", "gdpdef", "ff", "oph", "dtfp_util", "ur", "TFP"
))

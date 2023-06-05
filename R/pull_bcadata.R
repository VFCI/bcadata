#' Reconstruct BCA data from raw sources: FRED and TFP
#'
#' @param fred_api_key API key from FRED
#' @param vintage Boolean, use original paper vintage
#'
#' @return A tibble/data.frame
#' @export
#'
#' @examples
#' \dontrun{
#' data <- pull_bcadata("XXXXXXXXXXX")
#' }
pull_bcadata <- function(fred_api_key, vintage = FALSE) {
  fred_data <- pull_fred_data(fred_api_key)

  tfp_data <- pull_tfp_data(vintage)

  data <- transform_data(fred_data, tfp_data)

  return(data)
}

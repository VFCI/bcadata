#' Reconstruct BCA data from raw sources: FRED and TFP
#'
#' @param fred_api_key API key from FRED
#' @param replicate Boolean, use original paper vintage
#' @param vintage_date String date ("yyyy-mm-dd"), use given date as vintage
#'
#' @return A tibble/data.frame
#' @export
#'
#' @examples
#' \dontrun{
#' data <- pull_bcadata("XXXXXXXXXXX")
#' }
pull_bcadata <- function(
    fred_api_key,
    replicate = FALSE,
    vintage_date = NULL) {
  fred_data <- pull_fred_data(fred_api_key, replicate, vintage_date)

  tfp_data <- pull_tfp_data(replicate)

  data <- transform_data(fred_data, tfp_data)

  return(data)
}

#' Pull TFP data from San Franciso Fed website
#'
#' @return A tibble/data.frame
#' @export
#'
#' @examples
#' data <- pull_tfp_data()
pull_tfp_data <- function() {

    tfp_link <-
        "http://www.frbsf.org/economic-research/files/quarterly_tfp.xlsx"

    data <- openxlsx::read.xlsx(tfp_link, sheet = "quarterly", startRow = 2) |>
        dplyr::as_tibble()

    data <- data[, c("date", "dtfp_util")]

    data <- data[!is.na(data$dtfp_util), ]

    data <- data |>
        dplyr::mutate(
            date = zoo::as.Date.yearqtr(zoo::as.yearqtr(date, "%Y:Q%q"))
            )

    ## Last few rows are averages, have no date value, drop them
    data <- data[!is.na(data$date), ]

    return(data)
}

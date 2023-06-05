#' Pull TFP data from San Franciso Fed website
#'
#' @param vintage Boolean, use original paper vintage
#'
#' @return A tibble/data.frame
#'
pull_tfp_data <- function(vintage = FALSE) {
  if (vintage == TRUE) {
    vintage_link <- paste0(
      "https://drive.google.com/uc?export=download",
      "&id=1Amw-RcqwekawJbNvSFLzOE9w3DvjF9tt"
    )
    tfp_link <- tempfile(fileext = ".xlsx")

    utils::download.file(vintage_link, tfp_link)
  } else {
    tfp_link <-
      "http://www.frbsf.org/economic-research/files/quarterly_tfp.xlsx"
  }

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

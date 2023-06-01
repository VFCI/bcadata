#' Reconstruct BCA data from raw sources: FRED and TFP
#'
#' @param bcadata data.frame from pull_bcadata()
#'
#' @return A ggplot
#' @export
#'
#' @examples
#' \dontrun{
#' data <- compare_bcadata(pull_bcadata("XXXXXXXXXXX"))
#' }
compare_bcadata <- function(bcadata) {

    bcadata$version <- "Updated"
    original_bcadata$version <- "Original"

    data <- dplyr::bind_rows(bcadata, original_bcadata)

    data <- data |> tidyr::pivot_longer(!c("date", "version"))

    plot <- 
        data |>
        ggplot2::ggplot(ggplot2::aes_string(
            x = "date",
            y = "value",
            color = "version"
        )) +
        ggplot2::geom_line() + 
        ggplot2::facet_wrap(ggplot2::vars(name), ncol = 2, scales = "free_y")

  return(plot)
}
utils::globalVariables(c("name"))

#' Original Business Cycle Anatomy Dataset
#'
#' Pulled from the replication files and transformed into a tibble.
#' Ten U.S. macro time series from 1955 to 2017.
#'
#' @format ## `original_bcadata`
#' A data frame with 252 rows and 11 columns:
#' \describe{
#'   \item{date}{Year-Quarter Date}
#'   \item{output}{Real GDP per capita}
#'   \item{investment}{Real investment per capita}
#'   \item{consumption}{Real consumption per capita}
#'   \item{hours_worked}{Hours Worked}
#'   \item{unemployment}{Unemployment Rate (as percent)}
#'   \item{labor_share}{Labor share of output}
#'   \item{interest}{Fed Funds interest rate (quarterly rate, not annual)}
#'   \item{inflation}{Inflation rate, from GDP price deflator}
#'   \item{productivity}{Productivity (NFB)}
#'   \item{TFP}{Total Factor Productivity cummalitive}
#' }
#' @source <https://www.openicpsr.org/openicpsr/project/118082/version/V1/view>
"original_bcadata"

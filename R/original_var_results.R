#' Selected Original Business Cycle Anatomy VAR Impulse Response
#'
#' Pulled from the replication files and transformed into a tibble.
#' Impulse response to the "Main Business Cycle" shock of
#' ten U.S. macro time series, for a horizon of 40 quarters.
#' There are four different VAR models included.
#'
#' @format ## `original_bcadata`
#' A data frame with 1600 rows and 6 columns:
#' \describe{
#'   \item{horizon}{Impulse response horizon, in quarters}
#'   \item{median}{Median response of Bayesian iterations}
#'   \item{pctl_84}{Upper confidence band for 68%}
#'   \item{pctl_84}{Lower confidence band for 68%}
#'   \item{variable}{One of ten macro variables responding to the shock}
#'   \item{model}{VAR model trained as Bayesian or classical,
#'      targetting frequency domain (fd) or time domain (td)}
#' }
#' @source <https://www.openicpsr.org/openicpsr/project/118082/version/V1/view>
"original_var_results"

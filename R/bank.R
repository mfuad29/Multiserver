#' Bank Dataset
#'
#' A dataset containing customer arrival and service times.
#'
#' The dataset includes 100 records with the following columns:
#' \describe{
#'   \item{arrival_time}{Numeric: The arrival time of the customer.}
#'   \item{service_time}{Numeric: The time taken to serve the customer.}
#' }
#' @source Generated for the Multiserver package.
#' @format A data frame with 100 rows and 2 columns (after removing the unnamed column):
#' \itemize{
#'   \item arrival_time: Numeric arrival times.
#'   \item service_time: Numeric service times.
#' }
#'
#'@usage bank
#' @import readr
#' @export
bank <- readr::read_csv("data/bank.csv", col_types = cols(.default = col_double()))[-1]
library(tibble)
bank_tibble <- as_tibble(bank)



# tests/testthat/test-Multiserver.R

library(testthat)
library(Multiserver)  # Ensure the Multiserver package is loaded
library(readr)

bank_file_path <- system.file("data/bank.csv", package = "Multiserver")
bank <- read_csv(bank_file_path, col_types = cols(.default = col_double()))[-1]

# the arrival and service times from the bank dataset
test_arrivals <- bank$arrival_time
test_service_times <- bank$service_time
num_servers <- 2  # Example number of servers

test_that("Multiserver function works correctly with bank data", {
  # Run the Multiserver function with test data
  result <- Multiserver(test_arrivals, test_service_times, num_servers)

  #  the output to be a data frame with the correct number of rows
  expect_s3_class(result, "data.frame")  # Expect result to be a data frame
  expect_equal(nrow(result), length(test_arrivals))  # Number of rows should match arrivals

  #  specific values of the results
  expect_equal(result$ServiceBegins[1], test_arrivals[1])  # First customer should start at their arrival time
  expect_equal(result$ServiceEnds[1], test_arrivals[1] + test_service_times[1])  # End time should be arrival time + service time

  # the service end time of the second customer is correct
  expect_equal(result$ServiceEnds[2], result$ServiceBegins[2] + test_service_times[2])  # Should match calculated end time
})




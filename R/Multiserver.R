
#' Multiserver Package
#'
#' A package for simulating multi-server queue systems.
#'
#' @name Multiserver
#' @title Multiserver Package Title
#' @description the package provides tools for simulating "first come first serve" queing system with multiple servers, meaning it simulates multiserver queing systems based on customer arrival and service time data, which will calculate individual customer's waiting times, service times, and service end times.
#' @param Arrivals A numeric vector of customer arrival times.
#' @param ServiceTimes A numeric vector of customer service times.
#' @param NumServers An integer specifying the number of servers in the system (default is 1).
#'
#' @return
#'\item{Arrivals}{The arrival times of the customers.}
#'\item{ServiceBegins}{The times when each customer's service begins.}
#'\item{ChosenServer}{The server assigned to each customer.}
#'\item{ServiceEnds}{The times when each customer's service ends.}
#' @export


#' @examples
#' # Example usage:
#' arrivals <- c(1, 2, 4, 6)
#' service_times <- c(3, 2, 5, 1)
#' NumServers <- 2
#' Multiserver(arrivals, service_times, NumServers)
#'
Multiserver <- function(Arrivals, ServiceTimes, NumServers = 1) {
  if (any(Arrivals <= 0 | ServiceTimes <= 0) || NumServers <= 0){
    stop("Arrivals, ServiceTimes must be positive & NumServers must be positive" )
  }
  if (length(Arrivals) != length(ServiceTimes)){
    stop("Arrivals and ServiceTimes must have the same length")
  }
  # Feed customers through a multiserver queue system to determine each
  # customer's transition times.

  NumCust <- length(Arrivals)  #  number of customer arrivals
  # When each server is next available (this will be updated as the simulation proceeds):
  AvailableFrom <- rep(0, NumServers)
  # i.e., when the nth server will next be available

  # These variables will be filled up as the simulation proceeds:
  ChosenServer <- ServiceBegins <- ServiceEnds <- rep(0, NumCust)

  # ChosenServer = which server the ith customer will use
  # ServiceBegins = when the ith customer's service starts
  # ServiceEnds = when the ith customer's service ends

  # This loop calculates the queue system's "Transitions by Customer":
  for (i in seq_along(Arrivals)){
    # go to next available server
    avail <-  min(AvailableFrom)
    ChosenServer[i] <- which.min(AvailableFrom)
    # service begins as soon as server & customer are both ready
    ServiceBegins[i] <- max(avail, Arrivals[i])
    ServiceEnds[i] <- ServiceBegins[i] + ServiceTimes[i]
    # server becomes available again after serving ith customer
    AvailableFrom[ChosenServer[i]] <- ServiceEnds[i]
  }
  out <- tibble::tibble(Arrivals, ServiceBegins, ChosenServer, ServiceEnds)
  return(out)
}




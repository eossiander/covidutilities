#' Add the date of the last observed actual death counts in an IHME projection time series
#'
#' @param dat A dataframe or tibble containing an IHME projection.
#' @return A tibble containing an IHME projection, with a column containing the date
#' of the last observed data in the time series (i.e. the values of
#' \code{death_means} on that date and earlier dates are the observed death counts;
#' the values of \code{death_means} on later dates are projected values).
#' @examples
#' ihme_observed_date(df)
#' @export
ihme_observed_date <- function(dat){
    ## Add the date of the last observed death counts in the projection file
    ## (the date after which the projection time series switches from observed counts
    ##  to projected counts).
    ## These dates are verified only for Washington State
    projection  <-  dat$projection_date[1]
    .temp <- switch(projection,
                    "March 26" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-03-24"))
                    },
                    "March 27" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-03-24"))
                    },
                    "March 29" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-03-29"))
                    },
                    "March 30" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-03-30"))
                    },
                    "March 31" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-03-31"))
                    },
                    "April 1" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-04-01"))
                    },
                    "April 5" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-04-3"))
                    },
                    "April 7" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-04-03"))
                    },
                    "April 8" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-04-07"))
                    },
                    "April 10" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-04-09"))
                    },
                    "April 13" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-04-12"))
                    },
                    "April 17" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-04-16"))
                    },
                    "April 21" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-04-20"))
                    },
                    "April 22" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-04-21"))
                    },
                    "April 27" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-04-26"))
                    },
                    "April 28" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-04-27"))
                    },
                    "April 29" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-04-28"))
                    },
                    "May 4" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-05-01"))
                    },
                    "May 10" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-05-06"))
                    },
                    "May 12" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-05-09"))
                    },
                    "May 20" = {
                        dplyr::mutate(dat, last_observed_date = as.Date("2020-05-09"))
                    })
    .temp
}

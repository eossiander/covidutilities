#' Download the IHME projection from a specified projection date
#'
#' @param IHMEdate One of the dates on which IHME posted a projection.
#' Valid dates are March 26, March 27, March 29, March 30, March 31, April 1,
#' April 5, April 7, April 8, April 10, April 13, April 17, April 21, April 22,
#' April 27, April 28, April 29, May 4, and May 10
#' @return A tibble containing the IHME projection
#' @examples
#' ihme_projection <- ihme_download("April 22")
#' @export
ihme_download <- function(IHMEdate){
    ## download a zipped file with projections from IHME, and extract the csv file
    ## The csv file names are case sensitive
    .temp <- tempfile()
    .temp2 <- switch(IHMEdate,
                   "March 26" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-03-26/ihme-covid19.zip", .temp)
                       dplyr::rename(
                           readr::read_csv(unz(.temp, "2020_03_26/hospitalization_all_locs_corrected.csv")),
                           date = date_reported)
                   },
                   "March 27" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-03-27/ihme-covid19.zip", .temp)
                       dplyr::rename(
                           readr::read_csv(unz(.temp, "2020_03_27/hospitalization_all_locs_corrected.csv")),
                           date = date_reported)
                   },
                   "March 29" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-03-29/ihme-covid19.zip", .temp)
                       dplyr::rename(
                           readr::read_csv(unz(.temp, "2020_03_29/hospitalization_all_locs_corrected.csv")),
                           date = date_reported)
                   },
                   "March 30" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-03-30/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_03_30/Hospitalization_all_locs.csv"))
                   },
                   "March 31" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-03-31/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_03_31.1/Hospitalization_all_locs.csv"))
                   },
                   "April 1" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-01/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_04_01.2/Hospitalization_all_locs.csv"))
                   },
                   "April 5" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-05/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_04_05.05.us/Hospitalization_all_locs.csv"))
                   },
                   "April 7" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-07/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_04_05.08.all/Hospitalization_all_locs.csv"))
                   },
                   "April 8" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-08/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_04_07.06.all/Hospitalization_all_locs.csv"))
                   },
                   "April 10" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-10/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_04_09.04/Hospitalization_all_locs.csv"))
                   },
                   "April 13" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-13/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_04_12.02/Hospitalization_all_locs.csv"))
                   },
                   "April 17" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-17/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_04_16.05/Hospitalization_all_locs.csv"))
                   },
                   "April 21" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-21/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_04_20.02.all/Hospitalization_all_locs.csv"))
                   },
                   "April 22" = {
                       download.file("http://www.healthdata.org/sites/default/files/files/Projects/COVID/ihme-covid19-0422.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_04_21.08/Hospitalization_all_locs.csv"))
                   },
                   "April 27" = {
                       download.file("http://www.healthdata.org/sites/default/files/files/Projects/COVID/downloads_0427.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_04_26.08/Hospitalization_all_locs.csv"))
                   },
                   "April 28" = {
                       download.file("http://www.healthdata.org/sites/default/files/files/Projects/COVID/Downloads_0428.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_04_27.05.c/Hospitalization_all_locs.csv"))
                   },
                   "April 29" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-29/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_04_28.02/Hospitalization_all_locs.csv"))
                   },
                   "May 4" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-05-04/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_05_04/Hospitalization_all_locs.csv"))
                   },
                   "May 10" = {
                       download.file("https://ihmecovid19storage.blob.core.windows.net/archive/2020-05-10/ihme-covid19.zip", .temp)
                       readr::read_csv(unz(.temp, "2020_05_08/Hospitalization_all_locs.csv"))
                   },
                   stop(" Invalid IHME projection date. Valid dates are\n March 26, March 27, March 29, March 30, March 31,
 April 1, April 5, April 7, April 8, April 10, April 13, April 17, April 21, April 22,\n April 27, April 28, April 29, May 4 and May 10"))
    unlink(.temp)
    dplyr::mutate(.temp2, projection_date = IHMEdate)
}

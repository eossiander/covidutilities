#' Download the latest IHME projection
#'
#' @param latestdate A character string denoting the date of the projection, e.g. "May 12".
#' Defaults to "latest" if not specified
#' @return A tibble containing the latest IHME projection
#' @examples
#' ihme_projection <- ihme_latest()
#' @export
ihme_latest <- function(latestdate = "latest"){
    ## download a zipped file with projections from IHME, and extract the csv file
    ## The csv file names are case sensitive
    .temp <- tempfile()
    download.file("https://ihmecovid19storage.blob.core.windows.net/latest/ihme-covid19.zip", .temp)
    folder_name <- unzip(.temp, list = T)[1, 'Name']
    .temp2 <- readr::read_csv(unz(.temp, paste0(folder_name, "Hospitalization_all_locs.csv")))
    unlink(.temp)
    dplyr::mutate(.temp2, projection_date = latestdate)
}

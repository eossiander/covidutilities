#' Download the Google mobility data for the US or a selected US state.
#'
#' @param type The type of geographic region for which data is to be returned.
#' This is one of 'US', 'states', 'counties', or a US state name.
#' @param silent Default is FALSE. Indicates whether a message describing the download
#' should be displayed.
#' @return A tibble containing the Google community mobility reports data 
#' @examples
#' gmcr <- download_google_mobility(type = "Washington", silent = FALSE)
#' @export
download_google_mobility <- function(type = "states", silent = FALSE){
    ## Some code here is lifted from Joachim Gassen's tidycovid19 package
    if (length(silent) > 1 || !is.logical(silent))
        stop("'silent' needs to be a single logical value")
    if (!(type %in% c('US', 'us', 'states', 'States', 'counties', 'Counties', .US_states)))
        stop("'type' needs to be one of 'US', 'states', 'counties', or a US state name")

    url  <- "https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv"
    
    gm_spec <- readr::cols(country_region_code = readr::col_character(),
                           country_region = readr::col_character(),
                           sub_region_1 = readr::col_character(),
                           sub_region_2 = readr::col_character(),
                           date = readr::col_date(),
                           retail_and_recreation_percent_change_from_baseline = readr::col_integer(),
                           grocery_and_pharmacy_percent_change_from_baseline = readr::col_integer(),
                           parks_percent_change_from_baseline = readr::col_integer(),
                           transit_stations_percent_change_from_baseline = readr::col_integer(),
                           workplaces_percent_change_from_baseline = readr::col_integer(),
                           residential_percent_change_from_baseline = readr::col_integer())

    if(!silent) message(sprintf("Downloading '%s'.\n", url))    

    df <-
        readr::read_csv("https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv", col_types = gm_spec) %>%
        dplyr::filter(country_region == "United States") %>%
        dplyr::rename(
                   retail_recreation = retail_and_recreation_percent_change_from_baseline,
                   grocery_pharmacy = grocery_and_pharmacy_percent_change_from_baseline,
                   parks = parks_percent_change_from_baseline,
                   transit_stations = transit_stations_percent_change_from_baseline,
                   workplaces = workplaces_percent_change_from_baseline,
                   residential = residential_percent_change_from_baseline,
                   state = sub_region_1,
                   county = sub_region_2
               ) %>%
        dplyr::mutate(
                   date = lubridate::ymd(date),
                   timestamp = Sys.time()
               )
    if (type %in% c("us", "US")){
        gmcr <- filter(df, is.na(state), is.na(county))
    }
    if (type %in% c("states", "States")){
        gmcr <- filter(df, !is.na(state), is.na(county))
    }
    if (type %in% c("counties", "Counties")){
        gmcr <- filter(df, !is.na(county))
    }
    if (type %in% .US_states){
        gmcr <- filter(df, state == type, !is.na(county))
    }
    
    gmcr
}

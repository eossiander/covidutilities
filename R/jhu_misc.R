#' Download the Covid-19 death counts and case counts for the United States from
#' the JHUCSSE github site.
#' 
#' @return A tibble containing the death and case counts for the United States in long
#' format, combined in one file.
#' @seealso \code{jhudata_to_long}
#' @examples
#' df <- jhu_get_data()
#' @export
jhu_get_data <- function(){
    ## read the JHU case and death data for the US, convert the files to a long format, and combine them.
    confirmed_US <- readr::read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv", col_types = readr::cols())
    deaths_US <- readr::read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv", col_types = readr::cols())
    jhudata_to_long(confirmed_US) %>%
        dplyr::full_join(jhudata_to_long(deaths_US), by = c("state", "date"))
}

#' Extract the Washington State data from the JHUCSSE data
#' 
#' @param dat A dataframe or tibble containing JHUCSSE Covid-19 data
#' @return A dataframe containing the JHUCSSE data for Washington State only.
#' @examples
#' df_wa <- jhu_extractWA(df)
#' @export
jhu_extractWA <- function(dat){
    ## extract the Washington State data from the US data
    dplyr::filter(dat, state == "Washington")
}

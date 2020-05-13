#' Convert a dataframe containing the Covid-19 data from the Johns Hopkins University
#' Center for Systems Science and Engineering from the native wide format to a long
#' format, and add a column with daily death counts.
#' 
#' @param df A dataframe or tibble with the JHUCSSE data in wide format.
#' @return A tibble with the JHUCSSE data in long format.
#' The native wide format has a row for each geographic area, with a column for each
#' date containing the cumulative death count or case count for that date. The
#' long format returned by this function has row for each date for each geographic
#' area, and adds a column for the daily counts.
#' 
#' The function also removes all geographic areas except the 50 US states and the
#' District of Columbia, and removes unneeded fields.
#' @examples
#' newdf <- jhudata_to_long(df)
#' @export
jhudata_to_long <- function(df) {
    df_str <- deparse(substitute(df))
    var_str <- substr(df_str, 1, stringr::str_length(df_str) - 3)
    df %>%
        dplyr::rename(country = `Country_Region`, state = `Province_State`, county = Admin2) %>%
        dplyr::filter(country == "US", state %in% .US_states, stringr::str_sub(county, 1, 6) != "Out of") %>%
        dplyr::select(-UID, -iso2, -iso3, -code3, -Combined_Key, -Lat, -Long_, -county, -FIPS, -country) %>%
        dplyr::group_by(state) %>%
        dplyr::summarise_at(dplyr::vars(-dplyr::group_cols()), sum) %>%
        {
            if (var_str == "deaths") {
                tidyr::pivot_longer(.,
                             -c(state, Population), 
                             names_to = "date_str", 
                             values_to = paste0(var_str, "_cumul"))
            }
            else {
                tidyr::pivot_longer(.,
                             -c(state), 
                             names_to = "date_str", 
                             values_to = paste0(var_str, "_cumul"))
            }
        } %>%
        dplyr::mutate(date = as.Date(date_str, format = "%m/%d/%y")) %>%
        dplyr::arrange(state, date) %>%
        dplyr::mutate(!!paste0(var_str, "_day") := eval(as.name(paste0(var_str, "_cumul"))) -
                          dplyr::lag(eval(as.name(paste0(var_str, "_cumul"))))) %>%
        dplyr::filter(date != "2020-01-22") %>%
        dplyr::select(-date_str)
}

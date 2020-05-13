#' Extract the data for the 50 US states and the District of Columbia from a dataframe
#' containing an IHME projection.
#' 
#' @param dat A dataframe or tibble with an IHME projection.
#' @return A tibble with the projection for just the 50 US states and the District
#' of Columbia. The column naming the geographic area is renamed to \code{state}.
#' @seealso \code{ihme_extractWA}
#' @examples
#' newdf  <- ihme_extractUS(df)
#' @export
ihme_extractUS <- function(dat){
    ## Select the data for US states from the IHME data
    dat %>%
        dplyr::rename(state = location_name) %>%
        dplyr::filter(state %in% .US_states) %>%
        dplyr::select_if(!(names(.) %in% c('V1')))
        ## dplyr::select(state, date, allbed_mean, allbed_lower, allbed_upper, ICUbed_mean,
        ##        ICUbed_lower, ICUbed_upper, InvVen_mean, InvVen_lower, InvVen_upper,
        ##        deaths_mean, deaths_lower, deaths_upper, admis_mean, admis_lower,
        ##        admis_upper, newICU_mean, newICU_lower, newICU_upper, totdea_mean,
        ##        totdea_lower, totdea_upper, bedover_mean, bedover_lower, bedover_upper,
        ##        icuover_mean, icuover_lower, icuover_upper, projection_date)
}

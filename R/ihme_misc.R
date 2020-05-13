#' Extract the Washington State data from an IHME projection
#' 
#' @param dat A dataframe or tibble containing an IHME projection
#' @return A dataframe containing the IHME projection for Washington State only.
#' @examples
#' df_wa <- ihme_extractWA(df)
#' @export
ihme_extractWA <- function(dat){
    ## extract the Washington State data from the US data
    dplyr::filter(dat, state == "Washington")
}



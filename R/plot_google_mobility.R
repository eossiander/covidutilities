#' Plot the Google mobility data for the US, or a US state or counties.
#'
#' @param df The R dataframe containing the Google Mobility Community Reports data,
#' created by the function `download_google_mobility().`
#' @param level1 The level of geographic region for which data are to be plotted.
#' This is one of 'US', 'states', or a US state name.
#' @param level2 Default is NULL. The name of a county for which data are to be plotted.
#' The state must be named in `level1.` If NULL, the data are plotted for the geographic
#' region named in level1.
#' @return A plot object, with a Google Mobility Community Reports plot for the
#' US or for a single state or county in the US.
#' @examples
#' gmcrus <- download_google_mobility("US")
#' gmplot <- plot_google_mobility(df = gmcrus, level1 = "US", level2 = NULL)
#' gmplot
#' 
#' gmcrwa <- download_google_mobility("Washington")
#' gmplot1 <- plot_google_mobility(df = gmcrwa, level1 = "Washington", level2 = NULL)
#' gmplot1
#' 
#' gmplot2 <- plot_google_mobility(df = gmcrwa, level1 = "Washington", level2 = "Spokane County")
#' gmplot2
#' @export
plot_google_mobility <- function(df, level1 = "Washington", level2 = NULL){
    if (!(level1 %in% c('US', 'us', .US_states)))
        stop("'level1' needs to be 'US' or a US state name")

        category_labels <- c(
            "Grocery & pharmacy",
            "Parks",
            "Residential",
            "Retail & recreation",
            "Transit stations",
            "Workplaces")

    if (level1 %in% c('US','us')){
        if (any(!is.na(df$state)))
            stop("data frame needs to be for US only")
        
        data  <- dplyr::select(df, -state, -county)
        
        data2 <- tidyr::pivot_longer(data, -c(country_region, date, timestamp),
                              names_to = "category",
                              values_to = "percent_change")
        
        maxX <- max(data2$percent_change, na.rm = T)
        data2_labels <- data2 %>%
            dplyr::distinct(category, .keep_all = T) %>%
            dplyr::mutate(percent_change = maxX,
                   category_labels = dplyr::recode(category,
                                            grocery_pharmacy = "Grocery & pharmacy",
                                            parks = "Parks",
                                            residential = "Residential",
                                            retail_recreation = "Retail & recreation",
                                            transit_stations = "Transit stations",
                                            workplaces = "Workplaces"))
        p <- ggplot(data = data2, aes(x = date, y = percent_change)) +
            facet_wrap(~category, ncol = 2) +
            theme_bw() +
            geom_ribbon(aes(ymin = 0, ymax = percent_change), fill = "lightblue", color = "black") +
            geom_line(color = "blue") +
            geom_text(data = data2_labels, 
                      aes(label = category_labels), 
                      vjust = "inward", 
                      hjust = "inward",
                      fontface = "bold", 
                      color = "black", 
                      size = 3.5) +
            theme(
                ## turn off the strip label and tighten the panel spacing
                strip.text = element_blank(),
                panel.spacing.x = unit(0.2, "lines"),
                panel.spacing.y = unit(0.3, "lines"),
                panel.border = element_rect(color = "gray")
            ) +
            labs(x = "Date",
                 y = "Percent change from baseline",
                 title = data2_labels$country_region[1],
                 caption = "data: Google Mobility Community Reports") +
            theme(legend.position = "top")
    }
    if (level1 %in% .US_states & !is.null(level2)){
        if (!(level2 %in% names(table(df$county))))
            stop(paste(level2, "is not in", level1))
        data  <- dplyr::filter(df, state == level1, county == level2)
        
        data2 <- tidyr::pivot_longer(data, -c(country_region, state, county, date, timestamp),
                              names_to = "category",
                              values_to = "percent_change")
        
        maxX <- max(data2$percent_change, na.rm = T)
        data2_labels <- data2 %>%
            dplyr::distinct(category, .keep_all = T) %>%
            dplyr::mutate(percent_change = maxX,
                   category_labels = dplyr::recode(category,
                                            grocery_pharmacy = "Grocery & pharmacy",
                                            parks = "Parks",
                                            residential = "Residential",
                                            retail_recreation = "Retail & recreation",
                                            transit_stations = "Transit stations",
                                            workplaces = "Workplaces"))
        p <- ggplot(data = data2, aes(x = date, y = percent_change)) +
            facet_wrap(~category, ncol = 2) +
            theme_bw() +
            geom_ribbon(aes(ymin = 0, ymax = percent_change), fill = "lightblue", color = "black") +
            geom_line(color = "blue") +
            geom_text(data = data2_labels, 
                      aes(label = category_labels), 
                      vjust = "inward", 
                      hjust = "inward",
                      fontface = "bold", 
                      color = "black", 
                      size = 3.5) +
            theme(
                ## turn off the strip label and tighten the panel spacing
                strip.text = element_blank(),
                panel.spacing.x = unit(0.2, "lines"),
                panel.spacing.y = unit(0.3, "lines"),
                panel.border = element_rect(color = "gray")
            ) +
            labs(x = "Date",
                 y = "Percent change from baseline",
                 title = data2_labels$county[1],
                 caption = "data: Google Mobility Community Reports") +
            theme(legend.position = "top")
    }
    if (level1 %in% .US_states & is.null(level2)){
        if (!(level1 %in% names(table(df$state))))
            stop(paste(level1, "is not in dataframe"))
        data <- df %>%
            dplyr::filter(state == level1, is.na(county)) %>%
            dplyr::select(-county)
        
        data2 <- tidyr::pivot_longer(data, -c(country_region, state, date, timestamp),
                              names_to = "category",
                              values_to = "percent_change")
        
        maxX <- max(data2$percent_change, na.rm = T)
        data2_labels <- data2 %>%
            dplyr::distinct(category, .keep_all = T) %>%
            dplyr::mutate(percent_change = maxX,
                   category_labels = dplyr::recode(category,
                                            grocery_pharmacy = "Grocery & pharmacy",
                                            parks = "Parks",
                                            residential = "Residential",
                                            retail_recreation = "Retail & recreation",
                                            transit_stations = "Transit stations",
                                            workplaces = "Workplaces"))
        p <- ggplot(data = data2, aes(x = date, y = percent_change)) +
            facet_wrap(~category, ncol = 2) +
            theme_bw() +
            geom_ribbon(aes(ymin = 0, ymax = percent_change), fill = "lightblue", color = "black") +
            geom_line(color = "blue") +
            geom_text(data = data2_labels, 
                      aes(label = category_labels), 
                      vjust = "inward", 
                      hjust = "inward",
                      fontface = "bold", 
                      color = "black", 
                      size = 3.5) +
            theme(
                ## turn off the strip label and tighten the panel spacing
                strip.text = element_blank(),
                panel.spacing.x = unit(0.2, "lines"),
                panel.spacing.y = unit(0.3, "lines"),
                panel.border = element_rect(color = "gray")
            ) +
            labs(x = "Date",
                 y = "Percent change from baseline",
                 title = data2_labels$state[1],
                 caption = "data: Google Mobility Community Reports") +
            theme(legend.position = "top")
    }
    p
}


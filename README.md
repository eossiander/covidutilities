
<!-- README.md is generated from README.Rmd. Please edit that file -->

# covidutilities

<!-- badges: start -->

<!-- badges: end -->

The covidutilities package has functions for downloading and processing
two useful Covid-19 data sources.

  - IHME projections:
      - `ihme_download` downloads an IHME projection, specified by date,
      - `ihme_latest` downloads the latest IHME projection,
      - `ihme_extract_US` extracts the data for the 50 US states and the
        District of Columbia from an IHME projection file,
      - `ihme_observed_date` adds the date of the last observed data
        that was used in making a projection,
      - `ihme_extractWA` extracts Washington State data from an IHME
        projection.
  - Johns Hopkins data:
      - `jhu_get_data` downloads the latest data for the US from the
        Johns Hopkins University Center for Systems Science and
        Engineering github site and converts it from the original wide
        format to a ‘tidy’ long format,
      - `jhu_extractWA` extracts the Washington State data from the
        JHUCSSE data file.
  - Google mobility community reports:
      - `download_google_mobility` downloads Google mobility community
        reports data for the US or a selected US state,
      - `plot_google_mobility` plots Google mobility community reports
        data for the US, or for a selected US state or county.

## Installation

You can install the latest version of covidutilities from
[github](https://github.com/eossiander) with:

``` r
devtools::install_github("eossiander/covidutilities")
```

## Examples

Download an IHME projection, extract the data for Washington State, and
add the date of the last observed data:

``` r
library(covidutilities)
library(magrittr)
ihme_april29 <- ihme_download("April 29") %>%
    ihme_observed_date() %>%
    ihme_extractUS() %>%
    ihme_extractWA() 
```

Download the latest data from JHUCSSE and extract the Washington data:

``` r
library(covidutilities)
library(magrittr)
jhu <- jhu_get_data() %>%
    jhu_extractWA() 
```

Download and plot Google mobility community reports data:

``` r
library(covidutilities)
library(ggplot2)
library(magrittr)
## The US average
gmcrus <- download_google_mobility("US", silent = T)
gmplot <- plot_google_mobility(df = gmcrus, level1 = "US")

## Washington State
gmcrwa <- download_google_mobility("Washington", silent = T)
gmplot1 <- plot_google_mobility(df = gmcrwa, level1 = "Washington")

## Spokane County in Washington State
gmplot2 <- plot_google_mobility(df = gmcrwa, level1 = "Washington", level2 = "Spokane County")
```

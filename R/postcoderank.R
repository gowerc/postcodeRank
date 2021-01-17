#' @import dplyr
#' @import xml2
#' @import httr
#' @import readr
#' @keywords internal
"_PACKAGE"


#' Get lsoa numbers
#' @param postcode_info Postcode information datasets
#' @description
#' Utility function to pull LSOA numbers from the postcode_info dataset
#' @export
get_lsoa <- function(postcode_info){
    postcode_info %>% filter(label == "LSOA") %>% pull(value)
}


#' Get lsoa scores
#' @param LSOA LSOA number
#' @param data MDI source dataset
#' @description
#' Utility funciton to extract area scores from the MDI dataset based upon a LSOA number
#' @export
get_lsoa_scores <- function(LSOA, mdi){
    mdi %>% filter(`LSOA code (2011)` %in% LSOA)
}



#' Get postcore score information
#' @param postcode UK Postcode
#' @description
#' Returns the MDI scores for a given postcode based upon its LSOA region
postcodeRank_full <- function(postcode, mdi){
    postcode %>%
        get_postcode_info() %>%
        get_lsoa() %>%
        get_lsoa_scores(mdi)
}

postcodeRank_slim <- function(postcode, mdi){
    postcode <- stringr::str_replace(postcode, " ", "")
    postcodeRank_full(postcode, mdi) %>%
        select( contains("Decile")) %>%
        select( -contains("Sub-domain")) %>%
        tidyr::gather(Index, {{postcode}})
}

#' Get the MDI scores for various postcodes
#' @param postcodes character vector of postcodes
#' @param mdi MDI dataset (use get_mdi_data() if you don't have one already downloaded)
#' @export
postcodeRank <- function(postcodes, mdi){
    purrr::map( postcodes, postcodeRank_slim, mdi=mdi) %>%
        purrr::reduce(left_join, by = "Index")
}



#' Get multiple deprivation indicies data
#'
#' @param infile name of local csv file to save the data to
#' @description
#' Makes a local copy of the government provided indices of deprivation
#' @export
get_mdi_data <- function(){

    data_source <- FILE_2019

    resp <- GET(data_source)
    stop_for_status(resp)
    mdi <- resp %>% content(col_types = cols(), encoding = "utf-8", progress = FALSE)

    return(mdi)

}


FILE_2015 <- paste0(
    "https://assets.publishing.service.gov.uk/",
    "government/uploads/system/uploads/attachment_data/file/",
    "467774/File_7_ID_2015_All_ranks__deciles_and_scores_for_the",
    "_Indices_of_Deprivation__and_population_denominators.csv"
)


FILE_2019 <- paste0(
    "https://assets.publishing.service.gov.uk/",
    "government/uploads/system/uploads/attachment_data/file/",
    "840424/File_7_-_All_IoD2019_Scores__Ranks__Deciles_and_",
    "Population_Denominators_1.csv"
)


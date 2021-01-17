
#' Get postcode lookup info
#' @param postcode Single UK postcode i.e. "EC3N 4AB"
#' @description
#' Function takes a postcode and returns standard lookup information. Note that spaces are automatically removed.
#' Information is sourced from https://www.doogal.co.uk/ thus an internet connection is required to use this function.
#' @export
get_postcode_info <- function(postcode){

    # Remove spaces (common source of errors)
    postcode <- stringr::str_replace(postcode, " " , "")

    url_template <- "https://www.doogal.co.uk/ShowMap.php?postcode={postcode}"
    url <- glue::glue(url_template, postcode = postcode)

    # Fix issue with glue kicking up a spurious warning message when used with bind_rows
    class(url) <- "character"

    resp <- GET(url)
    stop_for_status(resp)

    geotab <- resp %>% content() %>% xml_find_all("//div[text()='Geography']/following-sibling::table/tr")
    demotab <- resp %>% content() %>% xml_find_all("//div[text()='Demographics']/following-sibling::table/tr")

    bind_rows(
        tibble(
            label = geotab %>% xml_find_all("./th")  %>% xml_text(),
            value = geotab %>% xml_find_all("./th/following-sibling::td") %>% xml_text()
        ),

        tibble(
            label = demotab %>% xml_find_all("./th")  %>% xml_text(),
            value = demotab %>% xml_find_all("./th/following-sibling::td[1]") %>% xml_text()
        ),

        tibble(
            label = "LSOA",
            value = demotab %>% xml_find_all("./th[contains(text(),'Lower')]/following-sibling::td[2]") %>% xml_text()
        ),

        tibble(
            label = "URL",
            value = url
        )
    )
}





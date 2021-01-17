# postcodeRank

The goal of this project is provide information on the "quality" of an area to support decisions on where to live / buy property.

## Installation 

To install the package run

```r
devtools::install_github("gowerc/postcodeRank")
``` 


## Details

The goal is to find some sort of metric to enable comparisons of different areas to help decide where to live.  In the end the main metric used is the [Index of Multiple Deprivation (2015)](https://www.gov.uk/government/statistics/english-indices-of-deprivation-2015).  This data is based on [LSOA codes](https://www.datadictionary.nhs.uk/data_dictionary/nhs_business_definitions/l/lower_layer_super_output_area_de.asp?shownav=1) and so this [website](https://www.doogal.co.uk/ShowMap.php) is used to convert postcodes into LSOA codes.


## Usage2 

Below is an example of how to use the package:

```r
library(postcodeRank)
mdi <- get_mdi_data()
postcodeRank( c("OX16 5TR", "M1 4QD", "SW9 8BS"), mdi=mdi)
```
```
#> # A tibble: 10 x 4
#>    Index                                                                                              OX165TR M14QD SW98BS
#>    <chr>                                                                                                <dbl> <dbl>  <dbl>
#>  1 Index of Multiple Deprivation (IMD) Decile (where 1 is most deprived 10% of LSOAs)                       2     3      2
#>  2 Income Decile (where 1 is most deprived 10% of LSOAs)                                                    3     8      3
#>  3 Employment Decile (where 1 is most deprived 10% of LSOAs)                                                2     8      3
#>  4 Education, Skills and Training Decile (where 1 is most deprived 10% of LSOAs)                            2     7      7
#>  5 Health Deprivation and Disability Decile (where 1 is most deprived 10% of LSOAs)                         2     2      2
#>  6 Crime Decile (where 1 is most deprived 10% of LSOAs)                                                     1     1      1
#>  7 Barriers to Housing and Services Decile (where 1 is most deprived 10% of LSOAs)                          6     2      3
#>  8 Living Environment Decile (where 1 is most deprived 10% of LSOAs)                                        2     1      1
#>  9 Income Deprivation Affecting Children Index (IDACI) Decile (where 1 is most deprived 10% of LSOAs)       3     2      1
#> 10 Income Deprivation Affecting Older People (IDAOPI) Decile (where 1 is most deprived 10% of LSOAs)        3     2      1
```




## Misc

Below are some addition things considered and some useful resources just for interest (they have not been used within this project)

- There is a [formal API](http://geoportal.statistics.gov.uk/datasets/80628f9289574ba4b39a76ca7830b7e9_0/data) to lookup LSOA codes from postcodes however at the time of creation I could not get it to work (and [static lookup files](https://data.gov.uk/dataset/9b090605-9861-4bb4-9fa4-6845daa2de9b/postcode-to-output-area-to-lower-layer-super-output-area-to-middle-layer-super-output-area-to-local-authority-district-february-2018-lookup-in-the-uk) are > 200 mb)
- The police have an [api](https://data.police.uk/docs/) for looking up crime data, also has options for just returning crime within a 1 mile radius)
-  ONS provide population estimates for output areas (OA, sub regions of LSOA standardised to have a mean of 1500 per OA) [link](https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/censusoutputareaestimatesinthelondonregionofengland)
- Formula for calculating distance between 2 lat,long coords [link](https://www.movable-type.co.uk/scripts/latlong.html) (also see the `geosphere::distm()` for R implementation)





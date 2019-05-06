query_map_biogrid <- readr::read_csv(system.file('extdata',
                                                'query_map_biogrid.csv',
                                                package = 'biogridapi'))
usethis::use_data(query_map_biogrid, overwrite = TRUE)

#' Query Map for biogrid API
#'
#' The object documents the different types of requests and their query
#' paramaters that are allowed by the API.
"query_map_biogrid"

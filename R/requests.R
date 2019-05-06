#' Get Interactions
#'
#' @param accessKey A \code{character}. Access Keys are free and openly
#' available at \url{https://webservice.thebiogrid.org/}. Defaulit is NULL.
#' @param geneList A \code{character} vector. Interactions between genes in
#' this list will be fetched. Default is NULL.
#' @param searchNames A \code{logical}. If \code{TRUE} (default), the
#' interactor OFFICIAL_SYMBOL will be examined for a match with the
#' \code{geneList}.
#' @param taxId A \code{numeric}. NCBI taxonomy identifiers.
#' The full list of supported organisms can be obtained by calling
#' \code{\link{organisms}}.
#' @param start A \code{numeric}. Results fetched will start at this value
#' d(efault 0).
#' @param max A \code{numeric}. Results fetched will end at this value range
#' from 0 to 10000 (default is 5).
#' @param htpThreshold A \code{logical}. Interactions whose Pubmed ID has more
#' than this number of interactions will be excluded from the results (default
#' is \code{FALSE}). Ignored if \code{excludePubmeds} is \code{FALSE}.
#' @param interSpeciesExcluded A \code{logical}. If \code{TRUE}, interactions
#' with interactors from different species will be excluded (default
#' \code{FALSE}).
#' @param selfInteractionsExcluded A \code{logical}. If \code{TRUE},
#' interactions with one interactor will be excluded (default \code{FALSE}).
#' @param includeEvidence  A \code{logical}. If \code{TRUE}, any interaction
#' evidence with its Experimental System in the \code{evidenceList} will be
#' included in the result (default \code{FALSE}).
#' @param searchIds A \code{logical}. If \code{TRUE}, the interactor
#' ENTREZ_GENE, ORDERED LOCUS and SYSTEMATIC_NAME (orf) will be examined for a
#' match with the \code{geneList} (default \code{FALSE}).
#' @param searchSynonyms A \code{logical}. If \code{TRUE}, the interactor
#' SYNONYM will be examined for a match with the \code{geneList} (default
#' \code{FALSE}).
#' @param searchBiogridIds A \code{logical}. If \code{TRUE}, the entries in
#' 'GENELIST' will be compared to BIOGRID internal IDS which are provided in
#'  all Tab2 formatted files (default \code{FALSE}).
#' @param excludeGenes A \code{logical}. If \code{TRUE}, interactions
#' containing genes in the \code{geneList} will be excluded from the results.
#' Ignored if one of \code{searchIds}, \code{searchNames},
#' \code{searchSynonyms} is not \code{TRUE} and
#' \code{additionalIdentifierTypes} is empty (default \code{FALSE}).
#' @param includeInteractors A \code{logical}. If \code{TRUE}, in addition to
#' interactions between genes on the \code{geneList}, interactions will also
#' be fetched which have only one interactor on the \code{geneList} (default
#' \code{FALSE}).
#' @param includeInteractorInteractions A \code{logical}. If \code{TRUE},
#' interactions between the \code{geneList}’s first order interactors will be
#' included (default \code{FALSE}). Ignored if \code{includeInteractors} is
#' \code{FALSE} or if \code{excludeGenes} is set to \code{TRUE}.
#' @param excludePubmeds A \code{logical}. If \code{FALSE} (default),
#' interactions with Pubmed ID in \code{pubmedList} will be included in the
#' results.
#' @param throughputTag A \code{character}. If set to 'low' or 'high', only
#' interactions with 'Low throughput' or 'High throughput' in the 'throughput'
#' field will be returned (default is 'any').
#' @param format A \code{character} only 'tab2' is used.
#' @param includeHeader A \code{logical}. If \code{TRUE}, the first line of the
#' result will be a BioGRID column header (always \code{TRUE}).
#' @param pubmedList A \code{character} vector. Interactions will be fetched
#' whose Pubmed Id is/ is not in this list, depending on the value of
#' \code{excludePubmeds}.
#' @param evidenceList A \code{character} vector. Any interaction evidence with
#' its Experimental System in the list will be excluded from the results unless
#' \code{includeEvidence} is set to \code{TRUE}. The full list can be obtained
#' by calling \code{\link{evidence}}.
#' @param additionalIdentifierTypes A \code{character} vector. Identifier types
#' on this list are examined for a match with the \code{geneList}. The full
#' list can be obtained by calling \code{\link{identifiers}}.
#'
#' @return A \code{tibble}
#' \describe{
#' \item{BioGRID Interaction ID}{A unique identifier for each interaction within the BioGRID database. Can be used to link to BioGRID interaction pages. For example: http://thebiogrid.org/interaction/616539}
#' \item{Entrez Gene ID for Interactor A}{The identifier from the Entrez-Gene database that corresponds to Interactor A. If no Entrez Gene ID is available, this will be a “-”.}
#' \item{Entrez Gene ID for Interactor B}{Same structure as column 2.}
#' \item{BioGRID ID for Interactor A}{The identifier in the BioGRID database that corresponds to Interactor A. These identifiers are best used for creating links to the BioGRID from your own websites or applications. To link to a page within our site, simply append the URL: http://thebiogrid.org/ID/ to each ID. For example, http://thebiogrid.org/31623/.}
#' \item{BioGRID ID for Interactor B}{Same structure as column 4.}
#' \item{Systematic name for Interactor A}{A plain text systematic name if known for interactor A. Will be a “-” if no name is available.}
#' \item{Systematic name for Interactor B}{Same structure as column 6.}
#' \item{Official symbol for Interactor A}{A common gene name/official symbol for interactor A. Will be a “-” if no name is available.}
#' \item{Official symbol for Interactor B}{Same structure as column 8.}
#' \item{Synonyms/Aliases for Interactor A}{A “|” separated list of alternate identifiers for interactor A. Will be “-” if no aliases are available.}
#' \item{Synonyms/Aliases for Interactor B}{Same stucture as column 10.}
#' \item{Experimental System Name}{One of the many Experimental Evidence Codes supported by the BioGRID.}
#' \item{Experimental System Type}{This will be either “physical” or “genetic” as a classification of the Experimental System Name.}
#' \item{First author surname of the publication in which the interaction has been shown, optionally followed by additional indicators, e.g}{Stephenson A (2005)}
#' \item{Pubmed ID}{ of the publication in which the interaction has been shown.}
#' \item{Organism ID for Interactor A}{This is the NCBI Taxonomy ID for Interactor A.}
#' \item{Organism ID for Interactor B}{Same structure as 16.}
#' \item{Interaction Throughput}{This will be either High Throughput, Low Throughput or Both (separated by “|”).}
#' \item{Quantitative Score}{This will be a positive for negative value recorded by the original publication depicting P-Values, Confidence Score, SGA Score, etc. Will be “-” if no score is reported.}
#' \item{Post Translational Modification}{For any Biochemical Activity experiments, this field will be filled with the associated post translational modification. Will be “-” if no modification is reported.}
#' \item{Phenotypes}{If any phenotype info is recorded, it will be provided here separated by “|”. Each phenotype will be of the format <phenotype>[<phenotype qualifier>]:<phenotype type>. Note that the phenotype types and qualifiers are optional and will only be present where recorded. Phenotypes may also have multiple qualifiers in which case unique qualifiers will be separated by carat (^). If no phenotype information is available, this field will contain “-”.}
#' \item{Qualifications}{If additional plain text information was recorded for an interaction, it will be listed with unique qualifiers separated by “|”. If no qualification is available, this field will contain “-”.}
#' \item{Tags}{If an interaction has been tagged with additional classifications, they will be provided in this column separated by “|”. If no tag information is available, this field will contain “-”.}
#' \item{Source Database}{This field will contain the name of the database in which this interaction was provided.}
#' }
#'
#' @source https://wiki.thebiogrid.org/doku.php/biogridrest
#' @source https://wiki.thebiogrid.org/doku.php/downloads
#'
#' @seealso identifiers
#' @seealso organisms
#' @seealso evidence
#'
#' @import apihelpers
#' @importFrom httr modify_url
#' @importFrom readr read_tsv
#'
#' @export
interactions <- function(accessKey = NULL, geneList = NULL, searchNames = TRUE, taxId,
                         start = 0, max = 5, htpThreshold = 0,
                         interSpeciesExcluded = FALSE, selfInteractionsExcluded = FALSE,
                         includeEvidence = FALSE, searchIds = FALSE,
                         searchSynonyms = FALSE, searchBiogridIds = FALSE,
                         excludeGenes = FALSE, includeInteractors = FALSE,
                         includeInteractorInteractions = FALSE, excludePubmeds = FALSE,
                         throughputTag = 'any', format = 'tab2', includeHeader = TRUE,
                         pubmedList, evidenceList, additionalIdentifierTypes) {
  # collect arguments in a list
  param <- as.list(environment())

  # remove missing arguments
  ind <- unlist(lapply(param, is.name))
  param <- param[!ind]

  # construct query
  query <- make_query(
    request = 'interactions',
    parameters = param,
    query_map = query_map_biogrid
  )

  # make url
  url <- modify_url('',
                    scheme = 'https',
                    hostname = 'webservice.thebiogrid.org',
                    path = 'interactions/',
                    query = query)

  # get response
  resp <- send_request(url)

  # format contents
  res <- format_content(resp)

  # return results
  return(res)
}

#' Get supported organisms
#'
#' @inheritParams interactions
#'
#' @return A \code{tibble}
#' \describe{
#' \item{taxId}{NCBI organism taxon ID.}
#' \item{taxName}{Organism name.}
#' }
#'
#' @source https://wiki.thebiogrid.org/doku.php/biogridrest
#'
#' @import apihelpers
#' @importFrom httr modify_url
#' @importFrom readr read_tsv
#'
#' @export
organisms <- function(accessKey = NULL) {
  # collect arguments in a list
  param <- as.list(environment())

  # remove missing arguments
  ind <- unlist(lapply(param, is.name))
  param <- param[!ind]

  # construct query
  query <- make_query(
    request = 'organisms',
    parameters = param,
    query_map = query_map_biogrid
  )

  # make url
  url <- modify_url('',
                    scheme = 'https',
                    hostname = 'webservice.thebiogrid.org',
                    path = 'organisms/',
                    query = query)

  # get response
  resp <- send_request(url)

  # format contents
  res <- format_content(resp,
                        read_function = read_tsv,
                        col_names = c('taxId', 'taxName'))

  # return results
  return(res)
}

#' Get supported identifiers
#'
#' @inheritParams interactions
#'
#' @return A \code{tibble}
#' \describe{
#' \item{additionalIdentifierTypes}{Supported identifier type.}
#' }
#'
#' @source https://wiki.thebiogrid.org/doku.php/biogridrest
#'
#' @import apihelpers
#' @importFrom httr modify_url
#' @importFrom readr read_tsv
#'
#' @export
identifiers <- function(accessKey = NULL) {
  # collect arguments in a list
  param <- as.list(environment())

  # remove missing arguments
  ind <- unlist(lapply(param, is.name))
  param <- param[!ind]

  # construct query
  query <- make_query(
    request = 'identifiers',
    parameters = param,
    query_map = query_map_biogrid
  )

  # make url
  url <- modify_url('',
                    scheme = 'https',
                    hostname = 'webservice.thebiogrid.org',
                    path = 'identifiers/',
                    query = query)

  # get response
  resp <- send_request(url)

  # format contents
  res <- format_content(resp,
                        read_function = read_tsv,
                        col_names = 'additionalIdentifierTypes')

  # return results
  return(res)
}

#' Get supported evidence types
#'
#' @inheritParams interactions
#'
#' @return A \code{tibble}
#' \describe{
#' \item{evidenceList}{Supported evidence type.}
#' }
#'
#' @source https://wiki.thebiogrid.org/doku.php/biogridrest
#'
#' @import apihelpers
#' @importFrom httr modify_url
#' @importFrom readr read_tsv
#'
#' @export
evidence <- function(accessKey = NULL) {
  # collect arguments in a list
  param <- as.list(environment())

  # remove missing arguments
  ind <- unlist(lapply(param, is.name))
  param <- param[!ind]

  # construct query
  query <- make_query(
    request = 'evidence',
    parameters = param,
    query_map = query_map_biogrid
  )

  # make url
  url <- modify_url('',
                    scheme = 'https',
                    hostname = 'webservice.thebiogrid.org',
                    path = 'evidence/',
                    query = query)

  # get response
  resp <- send_request(url)

  # format contents
  res <- format_content(resp,
                        read_function = read_tsv,
                        col_names = 'evidenceList')

  # return results
  return(res)
}

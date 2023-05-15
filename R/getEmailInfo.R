#' Checks the provided email address

#' @param email (required) The email address you want to check
#' @param catch_all If set to 1 we check if the email domain is a catch-all enabled domain (Only available in higher up plans)

#' @return Returns all available information about the specified email address.
#' @export


get_email_info <- function(email, catch_all = NULL) {

  # check for API key or ask for API key
  apikey <- emailvalidation_api_key()

  # ensure necessary packages are installed
  if (!requireNamespace("httr", quietly = TRUE)) {
    stop("Please install the 'httr' package to use this function.")
  }
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Please install the 'jsonlite' package to use this function.")
  }

  # define the API URL
  api_url <- "https://api.emailvalidation.io/v1/info"

  # generate query
  params <- list(apikey = apikey, email = email)

  # append params to query if not null

  if(!is.null(catch_all)) {
    params['catch_all'] <- catch_all
  }

  # make the API request
  response <- httr::GET(api_url, query = params)

  # check if the request was successful
  data <- success_check(response)

  data <- jsonlite::fromJSON(httr::content(response, as = 'text' ,type = 'application/json', encoding="UTF-8"), flatten = TRUE)

  # return the result
  return(data)
}

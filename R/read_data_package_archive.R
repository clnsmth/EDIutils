#' Read data package archive
#'
#' @description This function is DEPRECATED. Please use 
#' \code{download_data_package_archive()} instead.
#'
#' @param packageId (character) Data package identifier
#' @param transaction (character) Transaction identifier. This parameter is 
#' DEPRECATED.
#' @param path (character) Path of directory in which the result will be written
#' @param env (character) Repository environment. Can be: "production",
#' "staging", or "development".
#'
#' @return (.zip file) The data package archive of \code{packageId} requested
#' by \code{transaction}
#' 
#' @family Accessing
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' # Download zip archive
#' read_data_package_archive("knb-lter-sev.31999.1", path = tempdir())
#' #> |=============================================================| 100%
#' dir(tempdir())
#' #> [1] "knb-lter-sev.31999.1.zip"
#' }
#'
read_data_package_archive <- function(packageId,
                                      transaction,
                                      path,
                                      env = "production") {
  .Deprecated("download_data_package_archive")
  if (!missing(transaction)) {
    warning(
      "The 'transaction' parameter is deprecated and no longer required. ",
      "Please use 'download_data_package_archive()' instead.", 
      call. = FALSE
    )
  }
  download_data_package_archive(
    packageId = packageId,
    path = path,
    overwrite = TRUE,
    env = env
  )
}

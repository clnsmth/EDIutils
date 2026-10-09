#' Read data package archive (defunct)
#'
#' @description This function is defunct. Please use 
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
  .Defunct(
    new = "download_data_package_archive",
    package = "EDIutils",
    msg = "'read_data_package_archive()' is defunct. Use 'download_data_package_archive()' instead."
  )
}

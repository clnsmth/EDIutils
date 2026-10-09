#' Create data package archive (zip) (defunct)
#' 
#' This function is defunct. Please use 
#' \code{download_data_package_archive()} instead.
#'
#' @param packageId (character) Data package identifier
#' @param env (character) Repository environment. Can be: "production",
#' "staging", or "development".
#'
#' @return transaction (character) Transaction identifier.
#' 
#' @family Miscellaneous
#'
#' @export
#'
create_data_package_archive <- function(packageId, env = "production") {
  .Defunct(
    new = "download_data_package_archive",
    package = "EDIutils",
    msg = "'create_data_package_archive()' is defunct. Use 'download_data_package_archive()' instead."
  )
}

#' Download data package archive (.zip)
#'
#' @description Download a data package as a zipped archive (.zip) containing 
#' all data entities, metadata, and quality reports.
#'
#' @param packageId (character) Data package identifier of the form 
#' \code{"scope.identifier.revision"}
#' @param path (character) Path of directory in which the archive file will 
#' be written
#' @param overwrite (logical) Whether to overwrite an existing file if one 
#' already exists at the destination. Default is \code{FALSE}.
#' @param env (character) Repository environment. Can be: \code{"production"},
#' \code{"staging"}, or \code{"development"}. Default is \code{"production"}.
#'
#' @return (character) Full path to the downloaded \code{.zip} archive.
#' 
#' @family Accessing
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Download zip archive to a temporary directory
#' archive_path <- download_data_package_archive(
#'   packageId = "knb-lter-sev.31999.1", 
#'   path = tempdir()
#' )
#' archive_path
#' #> [1] "/tmp/Rtmp.../knb-lter-sev.31999.1.zip"
#' 
#' # Inspect contents of downloaded archive
#' utils::unzip(archive_path, list = TRUE)
#' }
download_data_package_archive <- function(packageId,
                                          path,
                                          overwrite = FALSE,
                                          env = "production") {
  # 1. Validate inputs
  if (!dir.exists(path)) {
    stop("Directory '", path, "' does not exist.", call. = FALSE)
  }
  dest <- file.path(path, paste0(packageId, ".zip"))
  if (file.exists(dest) && !overwrite) {
    stop("File '", dest, "' already exists. Set 'overwrite = TRUE' to replace it.", 
         call. = FALSE)
  }

  # 2. Build URL using central helper
  url <- paste0(
    base_url(env), "/package/download/eml/",
    paste(parse_packageId(packageId), collapse = "/")
  )

  # 3. Perform request with httr::write_disk
  resp <- api_get(
    url,
    set_user_agent(),
    handle = httr::handle(""),
    httr::write_disk(dest, overwrite = overwrite),
    httr::progress()
  )

  # 4. Handle HTTP errors and clean up corrupt file
  if (httr::http_error(resp)) {
    if (file.exists(dest)) {
      file.remove(dest)
    }
    msg <- httr::content(resp, as = "text", encoding = "UTF-8")
    httr::stop_for_status(resp, msg)
  }

  # 5. Handle mock playback in test mode (vcr does not invoke write_disk)
  if (is_vcr_replaying() && is.raw(resp$content)) {
    writeBin(resp$content, dest)
  }

  return(dest)
}
